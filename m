Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0A29D2BF0D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Dec 2004 05:02:36 +1100 (EST)
Date: Mon, 13 Dec 2004 10:02:33 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Andriy Korud <a.korud@vector.com.pl>
Message-ID: <20041213180233.GD917@gate.ebshome.net>
References: <20041207105250.C13540@home.com>
	<1102943302.28201.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1102943302.28201.14.camel@localhost>
Cc: jgarzik@pobox.com, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][EMAC] allow rx of the maximum sized VLAN tagged packets
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Dec 13, 2004 at 02:08:22PM +0100, Andriy Korud wrote:
> as I know from documentation and IBM's support when you program VTPID
> register, EMAC will receive only frames with programmed ID. Other frames
> will be received only if they do not exceed 1518 bytes.
> Can anybody please comment this?

I'm not sure I understand your question.

EMAC can process 1518-sized packets without any problems (1500 + 12 + 
2 + 4) even without this patch. These are normal (non-VLAN tagged 
packets).

With my patch EMAC will be able to receive 1522 sized frames which 
are VLAN-tagged with _any_ VLAN tag. Note VTPID contains L2 protocol 
id, _not_ VLAN/priority field itself. If frame is bigger than 1518 
but doesn't have 0x8100 right after the source MAC address, "Packet 
Too Long" error will be generated. 

Also, 440GX has an option to process jumbo frames, but this is 
completely different story.

--
Eugene
