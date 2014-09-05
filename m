Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 05EC11A00FF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 22:09:36 +1000 (EST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Fri, 5 Sep 2014 09:09:32 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id BEAE11DC005E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 08:09:28 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s85C8NLq37879890
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Sep 2014 09:08:24 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s85C9RmQ005251
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Sep 2014 08:09:27 -0400
Date: Fri, 5 Sep 2014 09:09:25 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v2] deb-pkg: Add support for powerpc little endian
Message-ID: <20140905120925.GB3846@oc0268524204.ibm.com>
References: <1409894927.11359.26.camel@ale.ozlabs.ibm.com>
 <20140905071344.GA16024@visitor2.iram.es>
 <1409903718.11359.30.camel@ale.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409903718.11359.30.camel@ale.ozlabs.ibm.com>
Cc: Michal Marek <mmarek@suse.cz>, linux-kbuild@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>,
 Leann Ogasawara <leann.ogasawara@canonical.com>,
 Ben Hutchings <ben@decadent.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 05, 2014 at 05:55:18PM +1000, Michael Neuling wrote:
> On Fri, 2014-09-05 at 09:13 +0200, Gabriel Paubert wrote:
> > On Fri, Sep 05, 2014 at 03:28:47PM +1000, Michael Neuling wrote:
> > > The Debian powerpc little endian architecture is called ppc64le.  This
> > 
> > Huh? ppc64le or ppc64el?
> 
> ppc64el.  Commit message is wrong.  Fixed below.
> 
> Mikey
> 
> 

What about ppc64?

Also, I sent that already a month ago. Both linuxppc-dev and Michal
Marek were on cc.

http://marc.info/?l=linux-kernel&m=140744360328562&w=2

Cascardo.

> From: Michael Neuling <mikey@neuling.org>
> 
> deb-pkg: Add support for powerpc little endian
> 
> The Debian powerpc little endian architecture is called ppc64el.  This
> is the default architecture used by Ubuntu for powerpc.
> 
> The below checks the kernel config to see if we are compiling little
> endian and sets the Debian arch appropriately.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> 
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index 35d5a58..6f4a1af 100644
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -37,7 +37,7 @@ create_package() {
>  	s390*)
>  		debarch=s390$(grep -q CONFIG_64BIT=y $KCONFIG_CONFIG && echo x || true) ;;
>  	ppc*)
> -		debarch=powerpc ;;
> +		debarch=$(grep -q CPU_LITTLE_ENDIAN=y $KCONFIG_CONFIG && echo ppc64el || echo powerpc) ;;
>  	parisc*)
>  		debarch=hppa ;;
>  	mips*)
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
