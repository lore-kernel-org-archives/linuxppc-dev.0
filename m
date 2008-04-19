Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1B026DDF4B
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 19:24:04 +1000 (EST)
In-Reply-To: <20080418161218.12738.25844.stgit@trillian.secretlab.ca>
References: <20080418161218.12738.25844.stgit@trillian.secretlab.ca>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <50bbe43673e46cc8d3a02eb4c03d87e9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/POWERPC] mpc5200: remove "mpc5200b-*" from compatible lists
	in dts files
Date: Sat, 19 Apr 2008 11:23:57 +0200
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, m8@semihalf.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The mpc5200b is a bug fix of the mpc5200 with a few incompatible 
> changes.
> By rights, the current dts trees are the most "correct", but in 
> practical
> purposes there is no value in the 5200b devices having 2 compatible
> entries for each internal peripheral node.  Freescale has done a good 
> job
> of documenting exactly where the incompatibilities lie, so it restrict
> the extra compatible properties to devices with *documented* changes.

And what happens when later an "undocumented change" is found?  The
device tree should always list the exact version of device used, even
if all clients (i.e., the Linux kernel) only use the less-specific
"compatible" value; that way, if a need to distinguish arises later
(e.g., a model-specific bug workaround), a client can detect the exact
model of device without needing a new device tree (that the client in
general has no control over).

> Removing the extra 'b' fields makes the device trees smaller

That's nice in general, but it hardly overrides more serious concerns.


Segher
