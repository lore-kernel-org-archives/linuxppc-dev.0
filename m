Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 99E371A0202
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 01:10:36 +1100 (AEDT)
Message-ID: <5693B7CC.8000905@maciej.szmigiero.name>
Date: Mon, 11 Jan 2016 15:10:20 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
References: <5677107C.60904@maciej.szmigiero.name>
 <CAOMZO5C+32Nn6+Nv9KeVrd_Qeso-wEZZNU45G8h+e6LHdMoQYw@mail.gmail.com>
 <CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com>
 <20160111140038.GC6588@sirena.org.uk>
In-Reply-To: <20160111140038.GC6588@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11.01.2016 15:00, Mark Brown wrote:
> On Mon, Jan 11, 2016 at 10:10:56AM -0200, Fabio Estevam wrote:
>> On Mon, Jan 11, 2016 at 10:04 AM, Fabio Estevam <festevam@gmail.com> wrote:
> 
>>> [    2.526984] ------------[ cut here ]------------
>>> [    2.531632] WARNING: CPU: 1 PID: 1 at kernel/locking/lockdep.c:2755
>>> lockdep_trace_alloc+0xf4/0x124()
> 
>> This fixes the warning:
> 
>> --- a/sound/soc/fsl/fsl_ssi.c
>> +++ b/sound/soc/fsl/fsl_ssi.c
>> @@ -180,7 +180,6 @@ static const struct regmap_config fsl_ssi_regconfig = {
>>         .volatile_reg = fsl_ssi_volatile_reg,
>>         .precious_reg = fsl_ssi_precious_reg,
>>         .writeable_reg = fsl_ssi_writeable_reg,
>> -       .cache_type = REGCACHE_RBTREE,
>>  };
> 
>> Is this the correct fix?
> 
> I suspect not, it looks like the driver is using the cache for
> suspend/resume handling.  I've dropped the patch for now.  Either the
> driver should explicitly write to the relevant registers outside of
> interrupt context to ensure the cache entry exists or it should keep the
> defaults and explicitly write them to hardware at startup to ensure
> sync (the former is more likely to be safe).

Is it acceptable to switch it to flat cache instead to not keep the register
defaults in driver?

Maciej
