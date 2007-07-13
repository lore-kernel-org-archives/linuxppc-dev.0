Return-Path: <akostop@inaccessnetworks.com>
Received: from inaccessnetworks.com (node3.inaccessnetworks.com
	[212.205.200.118]) by ozlabs.org (Postfix) with ESMTP id 7FE9BDDDF7
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 18:58:50 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by inaccessnetworks.com (8.13.6/8.13.5) with ESMTP id l6D8pNHx007060
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 11:51:23 +0300
Received: from inaccessnetworks.com ([127.0.0.1])
	by localhost (host11.inaccessnetworks.com [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP id 06809-08 for <linuxppc-dev@ozlabs.org>;
	Fri, 13 Jul 2007 11:51:22 +0300 (EEST)
Received: from phoenix (phoenix.priv.inaccessnetworks.com [192.168.1.7])
	by inaccessnetworks.com (8.13.6/8.13.5) with ESMTP id l6D8pKUr007055
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 11:51:20 +0300
Date: Fri, 13 Jul 2007 11:51:15 +0300
To: linuxppc-dev@ozlabs.org
Subject: questions about mpc82xx_ads and porting to other, similar, platform
From: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-7
MIME-Version: 1.0
Message-ID: <op.tveavpvdnhx3hy@phoenix>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,

I am trying to port kernel 2.6.22.1 to my own platform, which incorporat=
es  =

an mpc8275 chip. I'm using platform code for mpc82xx_ads as a template (=
is  =

this right in the first place?). I have a couple of questions:

1. mpc82xx_ads.c uses init_scc_ioports function to initialize the scc  =

uarts. However, this function is only used by the code in
arch/powerpc/sysdev/fsl_soc.c, and spefically in fs_enet_of_init(), whic=
h  =

is used to initialize the ethernet driver and not the cpm_uart driver.
On the other hand, cpm_uart_of_init() function seems to be the one that =
 =

initializes the uarts in cpm, and actually makes use of the device-id,  =

model, rx-clock and tx-clock properties of the scc nodes in OF tree. So,=
  =

AFAICT, init_scc_ioports should not be there, since it won't be actually=
  =

called at all (although I have not actually tested this - I haven't yet =
 =

managed to boot the kernel). Instead, cpm_uart_of_init should take care =
of  =

everything, except for the pport initialization, which is done in u-boot=
  =

anyway (at least in my case). Any thoughts on this?

2. I have also some questions regarding the device tree. Why are there t=
wo  =

nodes regarding the interrupt controller in there? and in the top level =
 =

node, what does this property means:  reg =3D <f8200000 f8200004>; ?
Finally, in the memory node, the reg property defines a second mem regio=
n,  =

(f4500000 f4500020). What is this? maybe a special memory mapped  =

peripheral of this board? If I have a board with many mem configurations=
  =

(e.g. it uses a DIMM SDRAM what can be changed), what value should I pla=
ce  =

in the mem node? I have to change dts every time I insert a new DIMM?

any help would be greatly appreciated,

thank you in advance

Alex
