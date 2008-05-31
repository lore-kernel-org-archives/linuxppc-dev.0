Return-Path: <alan@nishioka.com>
Received: from pro34.abac.com (pro34.abac.com [66.226.64.35])
	by ozlabs.org (Postfix) with ESMTP id 227B7DDE41
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 31 May 2008 20:45:53 +1000 (EST)
Received: from [192.168.1.64] (adsl-68-122-74-59.dsl.pltn13.pacbell.net
	[68.122.74.59]) (authenticated bits=0)
	by pro34.abac.com (8.14.1/8.14.1) with ESMTP id m4VANCoE082426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 31 May 2008 03:23:13 -0700 (PDT)
	(envelope-from alan@nishioka.com)
Message-ID: <4841270B.9080805@nishioka.com>
Date: Sat, 31 May 2008 03:23:07 -0700
From: Alan Nishioka <alan@nishioka.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: FW: Error occured when appended FPGA image in the section of
	.init.text then bootup
References: <BAY124-W49CC670970046CAE18FB33A8B90@phx.gbl>
In-Reply-To: <BAY124-W49CC670970046CAE18FB33A8B90@phx.gbl>
Content-Type: text/plain; charset=GB2312
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ÖìÀû´ï wrote:
>
>
>     The request below give rise to the problem.
>     I have some boards equiped with MPC8247 and FPGA without storage
>     media which used as a PCI interface. So when the linux bootup
>     before initialize the PCI, the code of FPGA will download. I
>     append the FPGA code file in the Kernel section '.init.text'. when
>     linux bootup firstly it check the board type(different board type
>     would download different code), and download fpga code. More board
>     types lead to more FPGA code. I append them all in the section of
>     '.init.text'. when the total size of the code reach out 2M. The
>     error occured. I read the '__log_buf' the kernel access some bad
>     area. As the powerpce603 will map 16M address use two bat, how and
>     why the problem occured, and how to solved it .
>

Since the error occurs at 2M, I am going to guess it is similar to
problem I had. The default link/load address for booting is 0x200000.

Here is a link:
<http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=14717>

This fix is for the arch/ppc tree. I don't know if the arch/powerpc tree
works the same way.

In the future, you should say what kernel version you are using and what
the error was.

Alan Nishioka
alan@nishioka.com
