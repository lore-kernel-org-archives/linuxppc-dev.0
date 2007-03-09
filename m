Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id 4917EDDED9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Mar 2007 08:44:26 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so1079819nfc
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 09 Mar 2007 13:44:25 -0800 (PST)
Message-ID: <528646bc0703091344t28c57cc3yf60980dfe748cad1@mail.gmail.com>
Date: Fri, 9 Mar 2007 14:44:25 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Kunal Arya" <kunalarya@gmail.com>
Subject: Re: Kernel locked at "Now booting the kernel", Xilinx ML310 PPC405GP
In-Reply-To: <68ee5ad90703091309s64018616v3ba2b25033e84844@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <68ee5ad90703091309s64018616v3ba2b25033e84844@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 3/9/07, Kunal Arya <kunalarya@gmail.com> wrote:
> I'm currently working on getting Linux running on the Xilinx ML310.
> I've followed all of the directions so far, but have run into a boot
> problem.
>
> I used the kernel sources from Montavista's RSYNC servers, using this command:
> rsync -avz source.mvista.com::linuxppc-2.4 .
>
> This appears to be kernel version 2.4.30-pre1, according to version.h

Oh, ick.  you might want to try 2.6.  2.4 is so crusty (but I do have
2.4 working on my virtex boards, so it's not unusable).  :-)

What's probably happening, is some code is trying to access device
registers after the MMU is turned on, but before ioremap is called on
the registers.  I've had this situation before.  I usually just trace
through the boot path to find out how far it gets before the trap so I
know which device driver is at fault.

If you can access memory, it's also useful to look at the contents of
__log_buf after the crash.  That will tell you approximately how far
boot proceeded.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
