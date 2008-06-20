Return-Path: <sanjay3000@yahoo.com>
Received: from web33102.mail.mud.yahoo.com (web33102.mail.mud.yahoo.com
	[209.191.69.132]) by ozlabs.org (Postfix) with SMTP id E337ADDF54
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 09:44:57 +1000 (EST)
Date: Fri, 20 Jun 2008 16:44:55 -0700 (PDT)
From: Sanjay Patel <sanjay3000@yahoo.com>
Subject: Re: [RFC 1/3] powerpc: __copy_tofrom_user tweaked for Cell
To: benh@kernel.crashing.org
In-Reply-To: <1214004027.8011.182.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <834245.69039.qm@web33102.mail.mud.yahoo.com>
Cc: Mark Nelson <markn@au1.ibm.com>, Gunnar von Boehn <VONBOEHN@de.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Michael Ellerman <ellerman@au1.ibm.com>, cbe-oss-dev@ozlabs.org
Reply-To: sanjay3000@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>




--- On Fri, 6/20/08, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> I though OS X had a trick with a CR bit that would disable
> the dcbz optimization on the first alignment fault ? Or did they
> totally remove it ?

Ah, it's coming back to me. :)

Apple added 'dcbz', removed it, and then there was the clever trick of optimizing the code path with a boot-time perf test and/or changing the code on the first fault...I'm not sure what's implemented in the recent builds.

If Linux can do something similar, that should allow good perf on cacheable and cache-inhibited space as well as different CPUs (eg, if 'dcba' is available, then you don't need the alignment fault hack).

--Sanjay


      
