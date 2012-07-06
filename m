Return-Path: <amodra@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9600C2C042E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2012 10:57:19 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so15635983pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jul 2012 17:57:17 -0700 (PDT)
Date: Fri, 6 Jul 2012 10:27:10 +0930
From: Alan Modra <amodra@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build failure after merge of the final tree
Message-ID: <20120706005709.GB5805@bubble.grove.modra.org>
References: <20120705183345.ee84ec1048a19aa1c7129578@canb.auug.org.au>
 <20120705094348.GA5805@bubble.grove.modra.org>
 <20120706102151.fd4f769cf2aa3f753ad178bf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120706102151.fd4f769cf2aa3f753ad178bf@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 06, 2012 at 10:21:51AM +1000, Stephen Rothwell wrote:
> which have now been fixed.  So would a simple patch that puts the
> _savegpr etc functions in their own section (defined how?) fix this for
> us?

Ah, the kernel provides its own save/restore functions, and these get
mashed into a .text containing normal functions with toc references by
ld -r.  Well, you could stop using ld -r.  Otherwise, try

 .section ".text.save.restore","ax",@progbits

-- 
Alan Modra
Australia Development Lab, IBM
