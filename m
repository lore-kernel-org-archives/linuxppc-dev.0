Return-Path: <matvejchikov@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.178])
	by ozlabs.org (Postfix) with ESMTP id 33C0EDE005
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Aug 2008 21:13:56 +1000 (EST)
Received: by ik-out-1112.google.com with SMTP id c21so2999114ika.1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Aug 2008 04:13:54 -0700 (PDT)
Message-ID: <8496f91a0808190413y69817434v2e340454941f97a0@mail.gmail.com>
Date: Tue, 19 Aug 2008 15:13:54 +0400
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: No output from SMC1 console with the 2.6.26 kernel (8xx based
	board)
In-Reply-To: <20080730154545.GB25428@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <8496f91a0807281243y2193dad5hc758444fe0a10258@mail.gmail.com>
	<488E2510.7070209@freescale.com>
	<8496f91a0807282310r5e70fe01v85b2ff2da7a80416@mail.gmail.com>
	<488F385B.9030504@nanometrics.ca>
	<8496f91a0807291136v172b3b16t170088faf3f30b5b@mail.gmail.com>
	<20080729193901.GC8051@ld0162-tx32.am.freescale.net>
	<8496f91a0807300237q302cafd3ga21ddb7bbc0bd513@mail.gmail.com>
	<20080730154545.GB25428@ld0162-tx32.am.freescale.net>
Cc: Ben Gardiner <BenGardiner@nanometrics.ca>, linuxppc-embedded@ozlabs.org
Reply-To: matvejchikov@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

The problem was in incorrect (not full) brg-node definition. Instead of
brg@119f0 {
    compatible = "fsl,cpm-brg", "fsl,cpm2-brg";
    reg = <119f0 10 115f0 10>;
 };
there must be:
brg@119f0 {
    compatible = "fsl,cpm-brg", "fsl,cpm2-brg";
    reg = <119f0 10 115f0 10>;
    clock-frequency = <my_clock_frequency>;
 };

The PQ2 (and some others) DTS files needs to be updated.

Thanks.
