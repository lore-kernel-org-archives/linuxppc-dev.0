From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Etsushi Kato <ekato@ees.hokudai.ac.jp>
Cc: <linuxppc-dev@lists.linuxppc.org>, <paulus@samba.org>
Subject: Re: tlbia and PPC603
Date: Thu, 20 Jun 2002 08:36:24 +0200
Message-Id: <20020620063624.17364@smtp.adsl.oleane.com>
In-Reply-To: <20020620165750B.ekato@ees.hokudai.ac.jp>
References: <20020620165750B.ekato@ees.hokudai.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hi Ben,
>Thank you for your reply.
>
>On Wed, Jun 19, 2002 at 05:51:37AM +0200,
>Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>> Try without the ethernet card and switch IDE DMA off and tell me if it is
>> stable, there could be some cache coherency issues with some of the
chipsets
>> used on these machines.
>
>I was able to use both IDE DMA and ethernet card on
>linux-2.4.13-pre3-ben0 without problems.

Do you still have this kernel source ? My local repository got
corrupted at some point so I can't go that far in the history.

I would appreciate if you could send me a tarball with at least
the content of arch/ppc/kernel, arch/ppc/mm and include/asm-ppc
so I can do some comparisons.

>Anyway I tried rsync kernel without CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
>and compiled tulip as modules (and not loaded), but it still dropped
>to xmon randomly.

Ok.

>> Another thing you can try is in set_context(), add an isync on the line
>> that contain the label "3:" as the doc states a context synchronizing
>> instruction should also be used for data sync. before mtsrin.
>
>I changed set_context() and  it might improve stableness somewhat, but
>still dropped to xmon at some occasion.

Hrm...

>> Hrm... just in case, try also changing the definition of tlbia macro
>> in ppc_asm.h to put isync's inside the loop, both before and after the
>> tlbie's (add too much is no problem for such a test) and tell me if it
>> has any effect.
>
>With this change combined with set_context() change, crashes
>disappeared during boot time (tested 10 times and all trial
>succeeded).  It is really improvement.  But still sometimes (5 times
>per 10) dropped to xmon while sshd is working by ssh connection from
>other machine.

Can you send me a couple of xmon backtraces with lookup in System.map ?

Also, please try editing arch/ppc/kernel/ppc_asm.h and change the definition
of SYNC, SYNC_601 and ISYNC_601 so they unconditionally do the various sync &
isync's (that is remove the BEGIN_FTR_SECTION and END_FTR_SECTION(...) lines
from them.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
