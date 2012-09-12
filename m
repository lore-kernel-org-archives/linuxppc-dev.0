Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C11E82C0093
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 20:38:23 +1000 (EST)
Message-ID: <1347446296.2276.0.camel@pasglop>
Subject: Re: [v3][PATCH 2/3] ppc/kprobe: complete kprobe and migrate
 exception frame
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Date: Wed, 12 Sep 2012 20:38:16 +1000
In-Reply-To: <50504DEE.6060903@windriver.com>
References: <1347330053-27039-1-git-send-email-tiejun.chen@windriver.com>
 <1347330053-27039-2-git-send-email-tiejun.chen@windriver.com>
 <1347342718.2603.38.camel@pasglop> <505049FE.8060204@windriver.com>
 <1347439382.2603.97.camel@pasglop> <50504DEE.6060903@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-09-12 at 16:55 +0800, tiejun.chen wrote:
> > to worry about nor stack frame to create etc...
> 
> If you don't like this v4, let me know and then I can go back memcpy
> for next 
> version. 

Just open code the whole copy. It should be easy really. As I said, you
have the src and dst already in registers and you know they are aligned,
so just put the size of the frame in a register (divided by 4), do an
mtctr and do a little load_update/store_update loop to do the copy, all
in the asm.

Ben.
