Return-Path: <acahalan@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by ozlabs.org (Postfix) with ESMTP id 3CAA6B70D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 03:06:06 +1100 (EST)
Received: by fxm2 with SMTP id 2so3609261fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 04 Oct 2010 09:06:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <63799.84.105.60.153.1286166325.squirrel@gate.crashing.org>
References: <AANLkTikPhpvJetY+NDFggYE6Wp6ppyt2BLmzEbsiwHuZ@mail.gmail.com>
	<63799.84.105.60.153.1286166325.squirrel@gate.crashing.org>
Date: Mon, 4 Oct 2010 12:06:03 -0400
Message-ID: <AANLkTikt9e5s3UUn1+k=NY7UhqosM5qkgdih=UD+Hd+L@mail.gmail.com>
Subject: Re: use of BAT before taking over the MMU
From: Albert Cahalan <acahalan@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 4, 2010 at 12:25 AM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:

> The PowerPC OF binding requires the firmware to save and restore
> the BATs on entry to / exit from the firmware.

This sucks, because using the BAT is **much** easier for
the firmware. In my case, it also means I don't need to worry
about Linux stomping on anything -- I have nothing in RAM.

(this is an emulator, but I don't want to cheat too much
because adding special cases affects performance)

Page tables would need to go in RAM. If Linux wants to
use that memory...? It seems that Linux does tend to ask;
will it panic if I refuse? Are there addresses Linux won't
ever ask for?

It also looks like I could just start up Linux w/o the MMU on.
I'm just making 1:1 mappings anyway.
