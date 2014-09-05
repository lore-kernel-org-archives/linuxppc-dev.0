Return-Path: <paubert@iram.es>
Received: from navarro.puc.rediris.es (unknown [IPv6:2001:720:418:ca01::139])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 796141A01A6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 17:50:48 +1000 (EST)
Date: Fri, 5 Sep 2014 09:13:44 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: deb-pkg: Add support for powerpc little endian
Message-ID: <20140905071344.GA16024@visitor2.iram.es>
References: <1409894927.11359.26.camel@ale.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409894927.11359.26.camel@ale.ozlabs.ibm.com>
Cc: Michal Marek <mmarek@suse.cz>, linux-kbuild@vger.kernel.org,
 Ben Hutchings <ben@decadent.org.uk>,
 linux-kernel <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>,
 Leann Ogasawara <leann.ogasawara@canonical.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 05, 2014 at 03:28:47PM +1000, Michael Neuling wrote:
> The Debian powerpc little endian architecture is called ppc64le.  This

Huh? ppc64le or ppc64el?

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


	Gabriel
