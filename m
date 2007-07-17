Return-Path: <sureshtang@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 28C88DDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jul 2007 15:59:05 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k40so92900ugc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Jul 2007 22:59:04 -0700 (PDT)
Message-ID: <e5eb93010707162259l2e78c524s32ff260b3d930bdb@mail.gmail.com>
Date: Tue, 17 Jul 2007 11:29:04 +0530
From: "suresh suresh" <sureshtang@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: Linuxppc-embedded Digest, Vol 35, Issue 33
In-Reply-To: <469B9825.6070507@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_47579_26217569.1184651944374"
References: <mailman.1061.1184600645.8639.linuxppc-embedded@ozlabs.org>
	<D83235F0F3C86D4D889D8B9A0DA8C6D78D7DE9@corpexc01.corp.networkrobots.com>
	<469B9825.6070507@freescale.com>
Cc: linuxppc-embedded@ozlabs.org, Siva Prasad <sprasad@bivio.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_47579_26217569.1184651944374
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks....

MPC8280 has internal memory space which contains Dualport(Dp) RAM. In the
DpRAM we allocate some tables and these has to store pointer of the buffers
which are allocated in external memory. Core will use this pointer to access
the buffers, basically these buffers are used for DMA.

Using IMMR register we can get physical address of the internal memory. Now
can I store the address return by the kmalloc() function? or I should
convert it into physical?

Please help me how to resove this address translation.


Regards,
Suresh

On 7/16/07, Scott Wood <scottwood@freescale.com> wrote:
>
> Siva Prasad wrote:
> > It returns kernel virtual address. If you use this buffer space for DMA,
> > please use appropriate flags. You may use __pa(address) or
> > virt_to_phys() to convert virtual to physical.
>
> No, you may not -- physical and DMA addresses are not always identical.
>   Use the DMA mapping API.
>
> -Scott
>
>

------=_Part_47579_26217569.1184651944374
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks....<br>
<br>
MPC8280 has internal memory space which contains Dualport(Dp) RAM. In
the DpRAM we allocate some tables and these has to store pointer of the
buffers which are allocated in external memory. Core will use this
pointer to access the buffers, basically these buffers are used for DMA.<br>
<br>
Using IMMR register we can get physical address of the internal memory.
Now can I store the address return by the kmalloc() function? or I
should convert it into physical?<br>
<br>
Please help me how to resove this address translation.<br>
<br>
<br>
Regards,<br>
Suresh<br><br><div><span class="gmail_quote">On 7/16/07, <b class="gmail_sendername">Scott Wood</b> &lt;<a href="mailto:scottwood@freescale.com">scottwood@freescale.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Siva Prasad wrote:<br>&gt; It returns kernel virtual address. If you use this buffer space for DMA,<br>&gt; please use appropriate flags. You may use __pa(address) or<br>&gt; virt_to_phys() to convert virtual to physical.
<br><br>No, you may not -- physical and DMA addresses are not always identical.<br>&nbsp;&nbsp;Use the DMA mapping API.<br><br>-Scott<br><br></blockquote></div><br>

------=_Part_47579_26217569.1184651944374--
