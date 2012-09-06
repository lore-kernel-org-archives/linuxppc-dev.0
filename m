Return-Path: <ananth@in.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C536A2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 18:20:33 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Thu, 6 Sep 2012 02:20:31 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5D45A19D8045
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 02:20:29 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q868KSCd243940
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Sep 2012 02:20:28 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q868KSSI022917
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Sep 2012 02:20:28 -0600
Date: Thu, 6 Sep 2012 13:50:24 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build failure after merge of the final tree
 (powerpc tree related)
Message-ID: <20120906082024.GB362@in.ibm.com>
References: <20120906171153.c80e87ea8db3dd3f4ac87cf5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120906171153.c80e87ea8db3dd3f4ac87cf5@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2012 at 05:11:53PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the final tree, today's linux-next build (powerpc allyesconfig)
> failed like this:
> 
> In file included from drivers/atm/fore200e.c:70:0:
> drivers/atm/fore200e.h:263:3: error: redefinition of typedef 'opcode_t' with different type
> arch/powerpc/include/asm/probes.h:25:13: note: previous declaration of 'opcode_t' was here
> 
> Caused by commit 7118e7e648e0 ("powerpc: Consolidate {k,u}probe
> definitions") from the powerpc tree.
> 
> I have reverted that commit (and the two following:
> 41ab5266c362	"powerpc: Add trap_nr to thread_struct"
> 8b7b80b9ebb4	"powerpc: Uprobes port to powerpc")
> for today.

Hi Stephen,

I have just posted a patch [1] to fix the issue.

Ananth

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-September/100813.html
