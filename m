Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 15 Sep 2005 01:58:09 +0200
References: <200509090623.41889.arnd@arndb.de>
	<06F93AF6-7AF8-4320-B9E3-CBF9EA333403@freescale.com>
In-Reply-To: <06F93AF6-7AF8-4320-B9E3-CBF9EA333403@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200509150158.10511.arnd@arndb.de>
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

On Middeweken 14 September 2005 21:11, Kumar Gala wrote:
> I not sure I understand what the introduction of the enum's gets us.
> 
It doesn't have to be an enum, it could just as well be a #define,
if we find that to be better in some way (maybe compile-time).

The general idea is to convert run-time checks into compile-time
checks in order to improve the running kernel. If you have

// start code
enum {
	FEATURE_1 = 1,
	FEATURE_2 = 2,
	PLATFORM_1 = FEATURE_1, 
	PLATFORM_2 = FEATURE_2, 
	PLATFORM_3 = FEATURE_1 | FEATURE_2,
	FEATURE_POSSIBLE = 
#ifdef CONFIG_PLATFORM_1
		PLATFORM_1 |
#endif
#ifdef CONFIG_FEATURE_2
		PLATFORM_2 |
#endif
#ifdef CONFIG_FEATURE_3
		PLATFORM_3 |
#endif
		0,
	FEATURE_ALWAYS =
#ifdef CONFIG_PLATFORM_1
		PLATFORM_1 &
#endif
#ifdef CONFIG_PLATFORM_2
		PLATFORM_2 &
#endif
#ifdef CONFIG_PLATFORM_3
		PLATFORM_3 &
#endif
		FEATURE_POSSIBLE,
};

static inline int have_feature(unsigned long feature)
{
    return (FEATURE_ALWAYS & feature) ||
           (FEATURE_POSSIBLE & runtime_feature & feature);
}

int foo();
int bar();
int main(void)
{
	if (have_feature(FEATURE_1))
		return foo();
	if (have_feature(FEATURE_2))
		return bar();
	return 0;
}
// end code

Then gcc will produce optimal object code for any combination
of CONFIG_PLATFORM_{1,2,3}. Of course I have to admit that the
header file is not exactly elegant ;-).

	Arnd <><
