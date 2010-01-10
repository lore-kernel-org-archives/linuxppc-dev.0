Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de (bu3sch.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5083EB7BC3
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jan 2010 05:16:14 +1100 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Allocator MAX_ORDER exceeds SECTION_SIZE
Date: Sun, 10 Jan 2010 19:15:55 +0100
References: <201001101431.10736.mb@bu3sch.de>
In-Reply-To: <201001101431.10736.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201001101915.57627.mb@bu3sch.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday 10 January 2010 14:31:09 Michael Buesch wrote:
> I get the following compilation failure, if 64k pages is selected
> on 2.6.32.3 on a PowerMAC config:
> 
> include/linux/mmzone.h:947:2: error: #error Allocator MAX_ORDER exceeds SECTION_SIZE
> 
> Any idea?
> 

Ok, I figured out that lowering CONFIG_FORCE_MAX_ZONEORDER from 13 to 9
seems to fix the problem.
That error message could really need some improvement and at least a hint on what to do and why.

I'm also wondering, if the kconfig entry for CONFIG_FORCE_MAX_ZONEORDER could
somehow be limited to 9, if 64k pages is enabled.

-- 
Greetings, Michael.
