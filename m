Return-Path: <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] remove gratuitous reads from maple pci config
	space methods
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <6681fdad128303fc62c86c2345aa33a4@kernel.crashing.org>
References: <20070809005044.GD10114@localdomain>
	<20070809030555.GA8261@localhost.localdomain>
	<20070809041632.GA13921@localdomain>
	<40561246eaa06210a2a607aa7ed67b02@kernel.crashing.org>
	<20070809212420.GD13921@localdomain>
	<6681fdad128303fc62c86c2345aa33a4@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 11 Aug 2007 18:41:29 -0500
Message-Id: <1186875689.1576.44.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> It should be fine on PowerMac as well -- all G5s use U3/U4,
> the workaround is for certain older Apple bridge chips.

Yeah, remove them. The workaround that is needed afaik is really only
the one that reads back the -address- before accessing the data register
(and I think it's sill needed on U3), but it's unrelated to what that
patch changes.

As I said on IRC, I suspect those reads come from misguided attempts on
my part to avoid the processor itself posting those writes, since we
want config space access to be synchronous all the way. In that case,
however, a sync will do the job just fine to ensure the previous write
did hit the bridge.

Cheers,
Ben.
