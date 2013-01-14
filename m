Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:4830:2446:ff00:4687:fcff:fea6:5117])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4CDC72C009E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 10:37:38 +1100 (EST)
Message-ID: <1358206641.4489.8.camel@smoke>
Subject: Re: PS3 platform is broken on Linux 3.7.0
From: Geoff Levand <geoff@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 14 Jan 2013 15:37:21 -0800
In-Reply-To: <1357956742.20936.11.camel@smoke>
References: <1355488506.55692113@f147.mail.ru>
 <1355954017.5397.53.camel@pasglop> <1357956742.20936.11.camel@smoke>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Phileas Fogg <phileas-fogg@mail.ru>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Fri, 2013-01-11 at 18:12 -0800, Geoff Levand wrote:
> I checked these, and Michael's 407821a34fce89b4f0b031dbab5cec7d059f46bc
> does indeed cause the LV1 hypervisor to panic early, and if that is
> reverted, Aneesh's 048ee0993ec8360abb0b51bdf8f8721e9ed62ec4 hits a BUG.

Just to give an update, I did a little more work on it and found that
the call to lv1_insert_htab_entry() inside ps3_hpte_insert() is
failing.

   http://git.kernel.org/?p=linux/kernel/git/geoff/ps3-linux.git;a=blob;f=arch/powerpc/platforms/ps3/htab.c;hb=HEAD#l70

The values of the variables printed all look strange compared with
commit 048ee0993 reverted.  I'll try do some more work on it this
week.

-Geoff
