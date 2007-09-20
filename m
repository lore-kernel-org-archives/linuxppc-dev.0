Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay011.isp.belgacom.be (mailrelay011.isp.belgacom.be
	[195.238.6.178]) by ozlabs.org (Postfix) with ESMTP id 6E565DDE19
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 21:22:13 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: 8270 & Watchdog - early start - II
Date: Thu, 20 Sep 2007 13:22:07 +0200
References: <AEA1A32F001C6B4F98614B5B80D7647D02D73DEB@esealmw115.eemea.ericsson.se>
	<AEA1A32F001C6B4F98614B5B80D7647D02D73F76@esealmw115.eemea.ericsson.se>
In-Reply-To: <AEA1A32F001C6B4F98614B5B80D7647D02D73F76@esealmw115.eemea.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200709201322.08359.laurentp@cse-semaphore.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 20 September 2007 12:06, Matias Sundman wrote:
> Hi Guys,
> The Software Service Register (SWSR) is 16-bit wide which Laurent
> Pinchart [laurentp@cse-semaphore.com] so nicely pointed out for me.
> So it actually works with;
> *((volatile unsigned short*)(0xf001000e))=3D0x556c;
> *((volatile unsigned short*)(0xf001000e))=3D0xaa39;

You still shouldn't use direct access with MMU enabled. Use the global CPM=
=20
mapping and the I/O access macros.

out_be16(&cpm2_immr->im_siu_conf.siu_82xx.sc_swsr, 0x556c);
out_be16(&cpm2_immr->im_siu_conf.siu_82xx.sc_swsr, 0xaa39);

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=C3=A9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75
