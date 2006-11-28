Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2D04767BC9
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Nov 2006 08:05:52 +1100 (EST)
Message-ID: <456CA4A6.60404@am.sony.com>
Date: Tue, 28 Nov 2006 13:05:42 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [POWERPC 6/9] ps3: multiplatform build fixes
References: <20061127181851.796747000@arndb.de>
	<20061127182431.191420000@arndb.de>
In-Reply-To: <20061127182431.191420000@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> A few code paths need to check whether or not they are running
> on the PS3's LV1 hypervisor before making hcalls. This introduces
> a new firmware feature bit for this, FW_FEATURE_PS3_LV1.
> 
> Now when both PS3 and IBM_CELL_BLADE are enabled, but not PSERIES,
> FW_FEATURE_PS3_LV1 and FW_FEATURE_LPAR get enabled at compile time,
> which is a bug. The same problem can also happen for (PPC_ISERIES &&
> !PPC_PSERIES && PPC_SOMETHING_ELSE). In order to solve this, I
> introduce a new CONFIG_PPC_NATIVE option that is set when at least
> one platform is selected that can run without a hypervisor and then
> turns the firmware feature check into a run-time option.
> 
> The new cell oprofile support that was recently merged does not
> work on hypervisor based platforms like the PS3, therefore make
> it depend on PPC_CELL_NATIVE instead of PPC_CELL. This may change
> if we get oprofile support for PS3.
> 
> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
