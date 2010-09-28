Return-Path: <ben@trinity.fluff.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99CD2B6EEC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Sep 2010 09:48:00 +1000 (EST)
Date: Wed, 29 Sep 2010 00:20:54 +0100
From: Ben Dooks <ben-i2c@fluff.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH (Option 1)] of/i2c: fix module load order issue caused
	by of_i2c.c
Message-ID: <20100928232054.GQ21564@trinity.fluff.org>
References: <20100924221313.28357.61419.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100924221313.28357.61419.stgit@angua>
Cc: mikpe@it.uu.se, linux-kernel@vger.kernel.org, rdunlap@xenotime.net,
	linux-i2c@vger.kernel.org, khali@linux-fr.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 24, 2010 at 04:14:53PM -0600, Grant Likely wrote:
> Commit 959e85f7, "i2c: add OF-style registration and binding" caused a
> module dependency loop where of_i2c.c calls functions in i2c-core, and
> i2c-core calls of_i2c_register_devices() in of_i2c.  This means that
> when i2c support is built as a module when CONFIG_OF is set, then
> neither i2c_core nor of_i2c are able to be loaded.
> 
> This patch fixes the problem by moving the of_i2c_register_devices()
> function into the body of i2c_core and renaming it to
> i2c_scan_of_devices (of_i2c_register_devices is analogous to the
> existing i2c_scan_static_board_info function and so should be named
> similarly).  This function isn't called by any code outside of
> i2c_core, and it must always be present when CONFIG_OF is selected, so
> it makes sense to locate it there.  When CONFIG_OF is not selected,
> of_i2c_register_devices() becomes a no-op.

I sort of go with this one.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
