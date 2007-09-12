Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 4AC93DDE0D
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 14:56:21 +1000 (EST)
Date: Wed, 12 Sep 2007 14:56:20 +1000
To: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC/PATCH] Implement {read,update}_persistent_clock. v2
Message-ID: <20070912045620.GI9814@bakeyournoodle.com>
References: <20070911081746.GF9814@bakeyournoodle.com>
	<4d781cd1a4751e20098cae29aa4d2b60@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4d781cd1a4751e20098cae29aa4d2b60@bga.com>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2007 at 09:34:13AM -0500, Milton Miller wrote:
 
> Previously we called ppc_md.get_boot_time at most once.  How about 
> moving the check for it into the if (first) block?

Yup on investigatiion it looks like moving it inside the "if (fist)" is
safe.
 
> Have you tested with a platform that doesn't implement get_rtc_time?

Well no I haven't.  AFAICT without my patch read_persistent_clock() is a
weak symbol that always returns 0.  So any platform that doesn't have a
ppc_md.get_boot_time() or ppc_md.get_rtc_time() will still get a 0 at
all the call sites.

I'll locate a machine and verify I'm not making things worse.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
