Return-Path: <linuxppc-dev+bounces-19108-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C3BFF60F4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 17:11:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flZQj1pctz2yfK;
	Wed, 01 Apr 2026 04:11:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774977085;
	cv=none; b=DLhDkqk6ktgsOpFMpCuPI3hYSvd2uUEr1hNXWZ7p/u8F/EWe1fFBb39ySHJs/JnCEU0/vuE4+1C+C1wPRBqTsUkgep4MhiqkuXPx6u8rzfipGQ6WF2Y81h8lvkYBsid7OQaIEwhhzYEganyhfXxBaltlj5kO6YBGgizQMCbTFzWpSQwtZnfvCS7XfvKhBykFQjMSQ/U8hyrRYpxdWxxqgPaK+fQSUx3Iyql0xFFU+ycGiqAvQKwcZHYmGvgggsngn3oeDLBwvHXv+vMMCvAhK++QSRECn1dFJuyek/yxwMcKwUd3zmRhV7L/uANPQ9uDiblerVGCIWqwQHazv9SRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774977085; c=relaxed/relaxed;
	bh=0A8UGKXCc3BslSs2TBStu2TiOGNDGUwYpsF6jg4eoM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCWUrfslic5vE+oFwYwG09NTACHO9PtsevCh8iZqiWFt/RbiezD8RXSPeQki12KGMeNIj7s7lq8v6yzmP7/CQIuMisSUTBEYUvE/zqMzWB7csXHBgGN4y+YOBGro2HNhuVY9xSxkVOhR3QGt+4uO4T9solfy3BdKbhMrv4XL/h3pxOthgDd8qAX29Iielt9C/Mz+YvWVgEO3dvveBI08HWgi0hmQwfyXB5Pf6TzKCVNuAdqYNVh64O/i0P4n7M883nWxWupthzEcLyJ1dMeVZdCaIEHGMONHo2cFXdKTLimgP62d7FeiHFPh9uxfVa92QPmfGcIunkxvHeADAYgSnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NRotyBw/; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NRotyBw/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flZQf74rtz2ydn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 04:11:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774977083; x=1806513083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GtvqYs/cKyskZarliVyoZyk6Lrz0zh2hjMq/BgJEN6A=;
  b=NRotyBw/HTiyJDX9rLuaTvI+3U/DfWs9ktrZYE2yEmdNAmcE1DFubaaq
   GQDsnSFVGwFQkJy2WJESf9v2rdrPjTyTvaYcAvcafRfZ6/MKFO3jziRkP
   u09s0KmPvfZUOP47U80qEsUDq/AapQ9KlOqCnlAdFRerTCzsAv/t3m7iK
   PBOnHcSiezlPhEoNpuGRikXKrCudJipw24Tfh8mU5Rp5lQi1eXFtmYorP
   4zoTXmpF0BG3olipIOcuoXSltC8ph+Z4MKVhWJnumbGkHF4mTP3aaNni3
   4iOMfvflfKTyzx06JJMeEJz2EuBB9Fg630XbD9Th8GJ82yPlrA09swUOp
   Q==;
X-CSE-ConnectionGUID: BqkD1u84SAqjvV9YpKLRbg==
X-CSE-MsgGUID: 7C0Lkc3GQL2kyL9h8SaQ3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="101452501"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="101452501"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 10:11:18 -0700
X-CSE-ConnectionGUID: r2xYqhAfS3+du50J680yKw==
X-CSE-MsgGUID: gPOK64SeQbOM5PtqQpcDlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="221563716"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 31 Mar 2026 10:11:16 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7ccT-000000003bB-2W3u;
	Tue, 31 Mar 2026 17:11:13 +0000
Date: Wed, 1 Apr 2026 01:10:55 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?iso-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Subject: Re: [PATCH] ALSA: aoa: i2sbus: clear stale prepared state
Message-ID: <202604010125.AvkWBYKI-lkp@intel.com>
References: <20260330-aoa-i2sbus-clear-stale-active-v1-1-47a6c0a3ac9e@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330-aoa-i2sbus-clear-stale-active-v1-1-47a6c0a3ac9e@gmail.com>

Hi Cássio,

kernel test robot noticed the following build errors:

[auto build test ERROR on 46a6512f4a74dd7b18d9a455669c226843fc49ce]

url:    https://github.com/intel-lab-lkp/linux/commits/C-ssio-Gabriel/ALSA-aoa-i2sbus-clear-stale-prepared-state/20260331-113724
base:   46a6512f4a74dd7b18d9a455669c226843fc49ce
patch link:    https://lore.kernel.org/r/20260330-aoa-i2sbus-clear-stale-active-v1-1-47a6c0a3ac9e%40gmail.com
patch subject: [PATCH] ALSA: aoa: i2sbus: clear stale prepared state
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260401/202604010125.AvkWBYKI-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260401/202604010125.AvkWBYKI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604010125.AvkWBYKI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> sound/aoa/soundbus/i2sbus/pcm.c:760:25: error: initialization of 'int (*)(struct snd_pcm_substream *, struct snd_pcm_hw_params *)' from incompatible pointer type 'int (*)(struct snd_pcm_substream *)' [-Wincompatible-pointer-types]
     760 |         .hw_params =    i2sbus_playback_hw_params,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   sound/aoa/soundbus/i2sbus/pcm.c:760:25: note: (near initialization for 'i2sbus_playback_ops.hw_params')
   sound/aoa/soundbus/i2sbus/pcm.c:313:12: note: 'i2sbus_playback_hw_params' declared here
     313 | static int i2sbus_playback_hw_params(struct snd_pcm_substream *substream)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~
   sound/aoa/soundbus/i2sbus/pcm.c:829:25: error: initialization of 'int (*)(struct snd_pcm_substream *, struct snd_pcm_hw_params *)' from incompatible pointer type 'int (*)(struct snd_pcm_substream *)' [-Wincompatible-pointer-types]
     829 |         .hw_params =    i2sbus_record_hw_params,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   sound/aoa/soundbus/i2sbus/pcm.c:829:25: note: (near initialization for 'i2sbus_record_ops.hw_params')
   sound/aoa/soundbus/i2sbus/pcm.c:323:12: note: 'i2sbus_record_hw_params' declared here
     323 | static int i2sbus_record_hw_params(struct snd_pcm_substream *substream)
         |            ^~~~~~~~~~~~~~~~~~~~~~~


vim +760 sound/aoa/soundbus/i2sbus/pcm.c

   756	
   757	static const struct snd_pcm_ops i2sbus_playback_ops = {
   758		.open =		i2sbus_playback_open,
   759		.close =	i2sbus_playback_close,
 > 760		.hw_params =	i2sbus_playback_hw_params,
   761		.hw_free =	i2sbus_playback_hw_free,
   762		.prepare =	i2sbus_playback_prepare,
   763		.trigger =	i2sbus_playback_trigger,
   764		.pointer =	i2sbus_playback_pointer,
   765	};
   766	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

