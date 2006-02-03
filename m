Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx019.isp.belgacom.be (outmx019.isp.belgacom.be
	[195.238.4.200])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B79D9689C0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 22:35:17 +1100 (EST)
Received: from outmx019.isp.belgacom.be (localhost [127.0.0.1])
	by outmx019.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k13BZ3eu002186
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Feb 2006 12:35:04 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: CPM2 USB driver & MPC8248
Date: Fri, 3 Feb 2006 12:34:58 +0100
References: <200602031210.12603.laurent.pinchart@tbox.biz>
In-Reply-To: <200602031210.12603.laurent.pinchart@tbox.biz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602031234.58813.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

after more testing, I found out that only the first 3 control URBs complete 
successfully. I tried to duplicate the first GET_DESCRIPTOR(CONFIG) request, 
and the second one which worked before now fails. If I unplug/replug the 
device, the first GET_DESCRIPTOR(DEVICE) request sent to device 0 from 
hub_port_init fails:

c0450260 133702068 S Ci:000:00 s 80 06 0100 0000 0040 64 <
c0450260 134700018 C Ci:000:00 -104 0
c0450260 134700053 S Ci:000:00 s 80 06 0100 0000 0040 64 <
c0450260 135700016 C Ci:000:00 -104 0
c0450260 135700049 S Ci:000:00 s 80 06 0100 0000 0040 64 <
c0450260 136700018 C Ci:000:00 -104 0

Hope this helps to diagnose the problem,

Laurent Pinchart
