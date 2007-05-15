Return-Path: <tnt@246tNt.com>
Received: from outmx005.isp.belgacom.be (outmx005.isp.belgacom.be
	[195.238.4.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 02E63DDDF8
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 08:27:21 +1000 (EST)
Received: from outmx005.isp.belgacom.be (localhost [127.0.0.1])
	by outmx005.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l4FMRAAR014346
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 00:27:10 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <464A33BB.9010208@246tNt.com>
Date: Wed, 16 May 2007 00:27:07 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/9] powerpc: BestComm core support for Freescale MPC5200
References: <11790019171838-git-send-email-tnt@246tNt.com>
	<11790019223299-git-send-email-tnt@246tNt.com>
	<11790019223880-git-send-email-tnt@246tNt.com>
	<11790019223925-git-send-email-tnt@246tNt.com>
	<11790019234031-git-send-email-tnt@246tNt.com>
	<781A28BA-63E5-41C4-93F7-B5C004F526AD@kernel.crashing.org>
In-Reply-To: <781A28BA-63E5-41C4-93F7-B5C004F526AD@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC dev ML <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>
> On May 12, 2007, at 3:31 PM, Sylvain Munaut wrote:
>
>> This patch adds support for the core of the BestComm API
>> for the Freescale MPC5200(b). The BestComm engine is a
>> microcode-controlled / tasks-based DMA used by several
>> of the onchip devices.
>>
>> Setting up the tasks / memory allocation and all common
>> low level functions are handled by this patch.
>> The specifics details of each tasks and their microcode
>> are split-out in separate patches.
>>
>> This is not the official API, but a much cleaner one.
>
> Can you give more detail about how the API works.
Yes, I'll try to write something that gives a little explanation for
Documentation/

In the mean time, here's a small informative text that
describe the API usage from a driver writer perspective :

   You need to allocate yourself a task, depending on
   what driver you're writing, that might be a generic
   one or one dedicated to that device (depends on the
   peripheral). For example FEC needs one TX and one RX
   task, both specialized.

   Each 'type' of task you can create has a specific
   function to create it. For example, to create a new
   instance of the FEC rx task, you call bcom_fec_rx_init.

   It returns a (struct bcom_task*) that's gonna be your link
   to bestcomm for all further calls.

   Each task "type" needs a different init function because
   depending on the microcode, the way to initialize it
   is slightly different ...

   Most task are buffer descriptor based (well ... currently,
   they all are but that's not an obligation), and the
   bestcomm API handle details of the BD ring commonly.
   It assumes each buffer descriptor is formed by a
   status word and a certain number of data pointers (1,2,..n).

   The signification of each of theses data pointers and
   of the status depends on the type of task. There is however
   a convention in all tasks that the upper 4 bits of the status
   are reserved for "Ready" flags and that the lsbs are for
   the length (how much lsb depends of task ...)

   When you need to submit a new buffer for sending, you just
   call bcom_prepare_next_buffer(...) that returns you a pointer
   to a (struct bcom_bd *) to fill up with the info you want
   (most often just the lenght and data pointers ...).
   When filled up, you just "push" the BD calling
   bcom_submit_next_buffer(...). Each time a BD is completed,
   bestcomm generates an interrupt and you just have to
   call bcom_retrieve_buffer(...) to reclaim the BD that was
   sent (along with the info needed to identify which one it is).

   For receive task, it's more or less the same except you
   submit empty buffer that bestcomm will fill up. And the
   status word in the bd you recover by calling _retrieve is
   gonna give you how many bytes were put into the buffer.



>
>> diff --git a/arch/powerpc/sysdev/bestcomm/Makefile
>> b/arch/powerpc/sysdev/bestcomm/Makefile
>> new file mode 100644
>> index 0000000..a24aa06
>> --- /dev/null
>> +++ b/arch/powerpc/sysdev/bestcomm/Makefile
>> @@ -0,0 +1,8 @@
>> +#
>> +# Makefile for BestComm & co
>> +#
>> +
>> +bestcomm-core-objs    := bestcomm.o sram.o
>> +
>> +obj-$(CONFIG_PPC_BESTCOMM)        += bestcomm-core.o
>
> Any reason why sram isn't on the ojb-$(CONFIG_PPC_BESTCOMM) line?
Huh, I want the module to be named bestcomm-core when built as modules,
is it possible to do it in another way ?
I'm not an expert as kbuild so if there is a better way ...

>>
>> +/* Debug Dump */
>> +
>> +#define BCOM_DPRINTK(a,b...) printk(KERN_DEBUG DRIVER_NAME ": " a,
>> ## b)
>
> We have dev_dbg and dev_printk can we not use them?

I don't use dev_dbg because I want the stuff printed even if DEBUG was
not defined when
compiling bestcomm-core.
Those are debug functions that a developer can call, from the driver, to
see what state bestcomm is
in. So when he calls them, the user expects them to print stuff,
regardless is DEBUG was defined
or not when compiling bestcomm-core ...
Same thing for pr_debug.

And dev_printk forces me to repeat "dev_printk(dev, KERN_DEBUG, " on
each line which makes
them very long ...

I could define BCOM_DPRINTK(a,b,...) as dev_printk(dev, KERN_DEBUG, ...)
if you think it's better.


>
> Would all bcom_dump_status(), bcom_dump_task(), bcom_dump_bdring be
> better using debugfs?  At minimum there should be a Kconfig option to
> enable bestcomm debug that enables this code.
Theses are _never_ called ...
They are just there because when you work on a driver and something goes
wrong, it's useful to print debug info to see exactly what happened at
that exact moment.
So for example when working on the sound driver, some times I got an
interrupt but no buffer was finished, printing the bestcomm status at
that exact moment in the ISR when detecting that condition allowed me to
figure out what was going on. On the final submitted driver the call
will be removed ...

>> +/* Private API */
>> +
>
> What's private about it?
Driver code should not use it directly.
Only task support code should use it.

(basically anything outside sysdev/bestcomm/* should not include
bestcomm_priv.h)

> It would probably be good for the API functions to have DocBook style
> comments.  See something like drivers/rapidio/rio.c for an example.
Yes that would be nice ... just need to write it ;)

>>
>> +void
>> +bcom_task_release(struct bcom_task *tsk)
> bcom_task_free() to match alloc/free semantics?
Ok, I'll change that.

>> +
>> +
>> +/* Public API */
>> +
> What's public about these?
Driver can use those ;)


Thanks for the comments.


    Sylvain
