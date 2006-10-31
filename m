Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt
	controller	support	for	ARCH=powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <4547093E.6070502@bplan-gmbh.de>
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>
	<1162268830.25682.271.camel@localhost.localdomain>
	<4546F68C.6070900@bplan-gmbh.de>
	<1162279296.25682.297.camel@localhost.localdomain>
	<45470006.1020004@bplan-gmbh.de>
	<1162281518.25682.305.camel@localhost.localdomain>
	<4547093E.6070502@bplan-gmbh.de>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 19:44:51 +1100
Message-Id: <1162284291.25682.323.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, sha@pengutronix.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> In my point of view, the Firmware main task is to init the HW. I do not 
> think it's a good idea to overwrite firmware hw settings in the common 
> code. In my mind, this should be done in platform specific area.

The setting of interrupt polarity is a matter that is at the edge
between firmware and OS responsibility. Remember that a lot of embedded
platforms have close to no useful firmware too.

There are reasons why there is an API for those. As long as the
device-tree contains correct polarity, it should be fine to let the pic
driver to the job as told.

Of course, if your device-tree has bugs, then adding that feature
afterward will suddenly break efika ...

Ben.
