Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8067D1007D4
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 15:59:38 +1100 (EST)
Message-ID: <4EE6DB8F.1050504@windriver.com>
Date: Tue, 13 Dec 2011 12:58:55 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/4] ppc32/kprobe: introduce copy_exc_stack
References: <1323679853-31751-1-git-send-email-tiejun.chen@windriver.com>	
 <1323679853-31751-3-git-send-email-tiejun.chen@windriver.com>
 <1323730871.19891.25.camel@pasglop>
In-Reply-To: <1323730871.19891.25.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Mon, 2011-12-12 at 16:50 +0800, Tiejun Chen wrote:
>> We need a copy mechanism to migrate exception stack. But looks copy_page()
>> already implement this well so we can complete copy_exc_stack() based on
>> that directly.
> 
> I'd rather you don't hijack copy_page which is quite sensitive. The
> emulation isn't performance critical so a "dumber" routine would work

Yes, I just think we should introduce good performance so I 'steal' the original
copy_page().

> fine.
> 
> Why not use memcpy ? You can call it from assembly.

I'd like to switch to memcpy.

Thanks
Tiejun
