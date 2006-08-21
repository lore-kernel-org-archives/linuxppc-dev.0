Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 7534F67C2F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 00:14:37 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so1628009ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Aug 2006 07:14:36 -0700 (PDT)
Message-ID: <528646bc0608210714g51928043lb729e80bda753d4d@mail.gmail.com>
Date: Mon, 21 Aug 2006 08:14:36 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Wade Maxfield" <wmaxfield@gmail.com>
Subject: Re: PPC beginner questions
In-Reply-To: <45a1b53e0608210651s4f5de382w77e092463dbbf5b7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <45a1b53e0608210651s4f5de382w77e092463dbbf5b7@mail.gmail.com>
Cc: ppc <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/21/06, Wade Maxfield <wmaxfield@gmail.com> wrote:
>
>   We are using Xilinx with PPC built in.
>
>    The PPC has a memory management unit.  All of the IP we've added is
> mapped to physical addresses.
>
>    1. Can I access the memory the peripherasl are mapped to directly within
> the driver without going through functions?

No, you need to map them into virtual memory, then you can use the in*
out* functions to read/write.  (You can also directly use the virtual
addresses as pointers, but in*/out* is more portable)

>        if NOT, then Do I use
>           1. ioremap(),
>           2. request_mem_region(),
>           3. request_region()
>           4. something else?

ioremap

>
>    2.  Are there any gotcha's with the ppc 405 that Xilinx uses that I
> should know about?

Yes, lots.  :)

Actually it's pretty straight forward.  Mainline Linux 2.6 contains
support for both the Virtex-II Pro and the Virtex 4, but not a lot of
device drivers.  The MontaVista 2.4 tree is supported by Xilinx with
drivers, but then you have to use linux 2.4.  :p

Also, it's a good idea to read the Xilinx errata.

have fun.
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
