Message-ID: <39D7ACEC.D8E572DE@mvista.com>
Date: Sun, 01 Oct 2000 17:30:20 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: frowand@mvista.com,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <19340822040932.8760@mailhost.mipsys.com>
		<Pine.LNX.4.10.10009281150130.3468-100000@cassiopeia.home>
		<14803.57550.118150.759977@argo.linuxcare.com.au>
		<39D41AA2.C586D738@mvista.com>
		<14804.7238.688771.238444@argo.linuxcare.com.au>
		<39D4E85F.926CFD5B@mvista.com>
		<14805.17492.766815.388301@argo.linuxcare.com.au>
		<39D66E4D.4364FC8B@mvista.com>
		<39D68EB8.4CAD5168@mvista.com> <14806.62164.27906.255635@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> Ummm, no, I think we may have a misunderstanding here.
>
> First, you can use ioremap before the kernel VM allocator is set up,


Yes, and I do that.  The problem is many of the embedded boards map
stuff
above 0xff000000 (or 0xf0000000), which overlaps your "standard" PowerPC
in/out mapping.

On systems that have PCI bridges, legacy hardware, and want to use
the standard drivers that in/out, I have to put the IO_BASE someplace
else, or remap everything later when the VM allocator is initialized.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
