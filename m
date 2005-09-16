Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 16 Sep 2005 05:11:38 +0200
References: <200509160056.32617.arnd@arndb.de>
	<D6BA4E97-B338-4584-8ECD-440FC70AFED0@freescale.com>
In-Reply-To: <D6BA4E97-B338-4584-8ECD-440FC70AFED0@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200509160511.39277.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, pantelis.antoniou@gmail.com,
	linuxppc64-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] powerpc: merge include/asm/cputable.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Freedag 16 September 2005 04:22, Kumar Gala wrote:

> > #define CPU_FTR_POSSIBLE CPU_FTR_PSERIES_POSSIBLE |  
> > CPU_FTR_PMAC_POSSIBLE \
> >          | CPU_FTR_...
> > #define CPU_FTR_ALWAYS CPU_FTR_POSSIBLE & CPU_FTR_PSERIES_ALWAYS \
> >         & CPU_FTR_PMAC_ALWAYS & CPU_FTR_ ...
> 
> Yes, something like that.  Why do we need the CPU_FTR_ALWAYS.  It  
> seems that CPU_FTR_POSSIBLE is sufficient.  I may just not understand  
> the purpose of CPU_FTR_ALWAYS.
>
> > One point to consider is that we traditionally use #ifdef in the
> > source for many places that could simply use cpu_has_feature(). E.g.
> > most instances of #ifdef CONFIG_ALTIVEC could be replaced by
> > cpu_has_feature(CPU_FTR_ALTIVEC) without additional run-time overhead.
> 
> These should stay as CONFIG options because to reduce the code size  
> of the kernel which is important to embedded people.

The whole point of the logic is to reduce code size, because gcc
is smart enough to remove all dead code then.
Consider again the definition of

| static inline int have_feature(unsigned long feature)
| {
|      return (FEATURE_ALWAYS & feature) ||
|             (FEATURE_POSSIBLE & runtime_feature & feature);
| }

If the feature is part of FEATURE_ALWAYS, this will be optimized to

|      return 1 || FEATURE_POSSIBLE & runtime_feature & feature;

and subsequently

|      return 1;

If it is not part of FEATURE_POSSIBLE, it it equivalent to

|      return 0 || (0 & runtime_feature & feature);

which becomes

|      return 0;


Any code inside of

|      if (0) { /* ... */ }

is only checked for syntax by gcc but will not end up in the object code.
For the 'if(1)' case, the code gets smaller as well, because the runtime
flag does not have to be dereferenced.

For some places, we might prefer to replace '#ifdef CONFIG_FOO' not with
have_feature(FOO), but rather with feature_possible(FOO), given a definition
of 

static inline int have_feature(unsigned int feature)
{
	return !!(FEATURE_POSSIBLE & feature);
}

which always get evaluated at compile time.

	Arnd <><
