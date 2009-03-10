Return-Path: <jwboyer@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id C6925DE08A
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 22:43:59 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 27so2365265wfd.15
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 04:43:58 -0700 (PDT)
Date: Tue, 10 Mar 2009 07:43:39 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Oops with 2.6.29-rc7 on POWER5
Message-ID: <20090310114339.GB12220@yoda.jdub.homelinux.org>
References: <20090310000559.GD2256@yoda.jdub.homelinux.org>
	<1236645375.7260.200.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1236645375.7260.200.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 10, 2009 at 11:36:15AM +1100, Benjamin Herrenschmidt wrote:
>On Mon, 2009-03-09 at 20:05 -0400, Josh Boyer wrote:
>> [c00000000fffb830] [c0000000005fe504] .mutex_lock_nested+0x78/0x4b0
>> (unreliable)
>> [c00000000fffb950] [c00000000039d520] .echo_char_raw+0x40/0x98
>> [c00000000fffb9f0] [c00000000039fd68] .n_tty_receive_buf+0xb48/0x1104
>> [c00000000fffbbb0] [c0000000003a3a08] .flush_to_ldisc+0x160/0x244
>> [c00000000fffbc80] [c0000000003a3b5c] .tty_flip_buffer_push+0x70/0x9c
>> [c00000000fffbd10] [c0000000003b9e94] .hvsi_interrupt+0x464/0x590
>> [c00000000fffbe50] [c000000000119168] .handle_IRQ_event+0x60/0xdc
>> [c00000000fffbef0] [c00000000011baf0] .handle_fasteoi_irq+0x108/0x1a8
>> 
>Do that patch help ?

Yes.  No more oopses on the hvc console when I hit 'enter'.

>Alan, any comment about the races talked about in those comments ? Are
>they still something I should worry about ?

If not, we should look at getting this into 2.6.29.  I know it's getting
very late, but having kernels oops whenever someone hits enter on the
console probably isn't very good either.

josh
