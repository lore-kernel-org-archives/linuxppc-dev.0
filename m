Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 39CF5DE0AB
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 02:31:19 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so159034anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 07:31:18 -0800 (PST)
Message-ID: <fa686aa40801100731k62b004ecq4f6058aea5df9da0@mail.gmail.com>
Date: Thu, 10 Jan 2008 08:31:18 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: benh@kernel.crashing.org
Subject: Platform matching style (was:: [RFC] add phy-handle property for
	fec_mpc52xx)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, olaf@aepfle.de, sven@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/9/08, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> As much as I despise having to work around firmware bugs, it looks
> indeed like this one has been broken for way too long to the point where
> users are being hurt, distros are being hurt, and telling people to
> whack things in nvramrc is just plain gross, so let's merge it.

Tangent question:

The Efika has device_type = "chrp" in the root node, but in Linux
Efika support does not use CHRP, it uses
arch/powerpc/platforms/52xx/efika.c.  However, if CHRP support is
compiled in then it will see the chrp device_type and bind to it
before efika.c has a chance to probe.  I see three reasonable
solutions to this:

1. Apply a device tree fixup to change device_type from "chrp" to
"efika" (the current solution)
2. Modify chrp_probe() to check specifically for the Efika when probing
3. Modify the link order so that Efika is probed before CHRP.

All three of these solutions will work, but I'd like to get opinions
on which is stylistically the best approach (or if there is another
approach I'm missing).

In general, I'm trying to reduce the Efika fixups down to only what is
absolutely necessary and as much as possible work with the provided
device tree.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
