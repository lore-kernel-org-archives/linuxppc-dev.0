Return-Path: <kalle.pokki@iki.fi>
Received: from smtp1.song.fi (smtp1.song.fi [194.100.2.121])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E841768463
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Oct 2005 18:13:19 +1000 (EST)
Message-ID: <43423996.7090403@iki.fi>
Date: Tue, 04 Oct 2005 10:13:10 +0200
From: Kalle Pokki <kalle.pokki@iki.fi>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
	<4333DF04.3000908@iki.fi> <43395322.1080407@iki.fi>
	<384d09b865d454875c447cc02c89d001@embeddedalley.com>
	<4339AD01.30708@iki.fi>
	<714c16295fbfa97caafd1d0aa3a5932e@embeddedalley.com>
	<433A6E6D.4070403@iki.fi> <433BDCE7.2060206@iki.fi>
	<20050930142218.348041d6.ajz@cambridgebroadband.com>
	<2c578118c5d984e6e87ac3c073469866@embeddededge.com>
	<433D9BCE.5000909@iki.fi>
	<6eac69d46b656d812783d81a6ebeac84@embeddededge.com>
	<433E2530.7090503@iki.fi>
	<26a6f673ac9438729eccfe0c376c6b3d@embeddedalley.com>
	<4340D7EF.2040709@iki.fi>
In-Reply-To: <4340D7EF.2040709@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Dan Malek <dan@embeddedalley.com>, linuxppc-embedded@ozlabs.org
Subject: Re: CPM2 early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I found it. It's in the MPC8272 family errata. When setting pipeline 
depth to one everything works. Can you Alex confirm this works also for 
you? This errata should probably be included in the Linux kernel, since 
it really depends on it. Right now I set this from the boot loader, but 
perhaps head.S in the kernel would be the just as good.

Part I System Interface Unit (SIU) Errata
SIU18: ARTRY assertion when using pipeline depth of 0.
Devices:
MPC8272, MPC8271, MPC8248, MPC8247
Description:
Internal (60x) slave maintains a pipeline depth of zero by asserting 
AACK only after TA. When ARTRY is
asserted, the 60x bus access is terminated and TA is not asserted. The 
internal (60x) slave does not assert
AACK, since TA was not asserted.
Workaround:
Use a pipeline depth of one (BCR[PLDP]=0) for applications that require 
memory coherency.
Fix Plan:
No fix plan at this time.
