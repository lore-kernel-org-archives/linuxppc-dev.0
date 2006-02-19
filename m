Return-Path: <kashiwagi@co-nss.co.jp>
Received: from nssinet2.co-nss.co.jp (nssinet2.co-nss.co.jp [150.96.0.5])
	by ozlabs.org (Postfix) with ESMTP id 7E367679E7
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 19 Feb 2006 22:39:43 +1100 (EST)
Received: from nssinet2.co-nss.co.jp (localhost [127.0.0.1])
	by nssinet2.co-nss.co.jp (8.9.3/3.7W) with ESMTP id UAA11967
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 19 Feb 2006 20:23:00 +0900 (JST)
MIME-Version: 1.0
Date: Sun, 19 Feb 2006 20:39:43 +0900
Subject: Re: Virtex-4 TEMAC device driver available?
From: Yoshio Kashiwagi <kashiwagi@co-nss.co.jp>
To: "S. Egbert" <s.egbert@sbcglobal.net>, linuxppc-embedded@ozlabs.org
Message-ID: <JS200602192039433.11799406@co-nss.co.jp>
Content-Type: text/plain; charset=ISO-2022-JP
In-Reply-To: <43F7CB11.5000202@sbcglobal.net>
References: 93579fec0601170146h5363e65bt410276b8b696588f@mail.gmail.com
	<43F7CB11.5000202@sbcglobal.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Steve San,

Strictly, GSRD differs from TEMAC.
Although both are embedded TEMAC is used in Virtex4, GSRD accesses
direct memory through MPMC. MPMC is a multi-port memory controller
for GSRD to access direct memory. 

http://www.xilinx.com/esp/wired/optical/xlnx_net/gsrd_download.htm

Download of GSRD is linked out of the above-mentioned URL, and
becomes a place to be logged in (Registration for downloading the
reference design short cut).
http://www.xilinx.com/xlnx/xil_entry2.jsp?sMode=login&group=gsrd

Linux2.4 driver is contained in this GSRD. However, this Linux2.4
driver (adapter.c) has the fault which does not operate correctly,
when a 100BASE hub is connected. In order to correct this problem,
it is necessary to add the interrupt handling routine of PHY.
Although this GSRD is a reference design more nearly high-speed
than TEMAC, many FPGA resources are used for it.

I am going to create a TEMAC driver (Linux2.6) by a scratch, I
cannot make time for it now. Since it is due to make by the end of
this month, if it is completed, I'll announce it to this mailing
list.

I'll write the Linux2.6 TEMAC driver corresponding to the following
reference designs. 
http://direct.xilinx.com/bvdocs/appnotes/xapp902.pdf
http://www.xilinx.com/bvdocs/appnotes/xapp902.zip
(The Linux driver is not contained in this reference design)

Best Regards,

Yoshio Kashiwagi - Nissin Systems

> Dear Kashiwagi-San,
> 
> I noticed in your posting over at linuxppc-embedded in Jan 2006 about 
a
> Xilinx demo code for the TEMAC driver.
> 
> So, I pulled the
> http://www.xilinx.co.jp/ise/embedded/EDK/71i/mpmc_7_1_2.zip file and
> browsed it.
> 
> Do you know where one can get a patch for Linux 2.4?
> 
> Thank you,
> 
> Steve Egbert
> 
> -- 
> -----BEGIN GEEK CODE BLOCK-----
> Version: 3.12
> GAT d- s++: !a C+++ UL++++ P+++ L+++ E W+++ N+ o++ K+++ w--
> O- M+ V- PS PE++ Y+ PGP++ t++ 5++ X++ R tv- b++ DI+ D+
> G++ e* h++ r+++ z
> ------END GEEK CODE BLOCK------
> GPG Public Key: http://www.egbert.net/pgp
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
