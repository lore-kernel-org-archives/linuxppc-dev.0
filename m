Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id E3F2EDDE29
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 08:45:29 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 2/2] Cell: Wrap master run control bit
Date: Wed, 5 Sep 2007 00:42:13 +0200
References: <46DD4783.9040103@am.sony.com>
In-Reply-To: <46DD4783.9040103@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200709050042.13926.arnd@arndb.de>
Cc: Masato Noguchi <Masato.Noguchi@jp.sony.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 04 September 2007, Geoff Levand wrote:
> 
> From: Masato Noguchi <Masato.Noguchi@jp.sony.com>
> 
> Add platform specific SPU run control routines.
> 
> The current spufs_run_spu() implementation uses the SPU master
> run control bit (MFC_SR1[S]) to control SPE execution, but the
> PS3 hypervisor does not support the use of this feature.  This
> change adds run control wrapper routines.  The  bare metal
> routines use the master run control bit, and the PS3 specific
> routines use the priv2 run control register.
> 
> Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Hmm, ok. Since I don't think we'll get to do the right solution
(unmapping the ps registers on the ps3) that soon, doing this
patch is at least better than the current situation where we
end up with an oops every time we leave spu_run.

It would probably be good to mention the remaining problem
with the current approach in the changelog and as a comment
in the ps3 specific functions.

> @@ -178,6 +179,8 @@ struct spu_management_ops {
>  	int (*enumerate_spus)(int (*fn)(void *data));
>  	int (*create_spu)(struct spu *spu, void *data);
>  	int (*destroy_spu)(struct spu *spu);
> +	int (*enable_spu)(struct spu_context *ctx);
> +	int (*disable_spu)(struct spu_context *ctx);
>  	int (*init_affinity)(void);
>  };

Also, I think you should make the return type of the callback
'void' since the result is not used anywhere.

	Arnd <><
