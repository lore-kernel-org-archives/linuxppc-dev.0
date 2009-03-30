Return-Path: <pku.leo@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by ozlabs.org (Postfix) with ESMTP id 3A84CDDE17
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 18:36:23 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so2170862wfg.15
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 00:36:21 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <OF073D5C49.F0D791DE-ONC1257586.0040163D-C1257586.00413F47@transmode.se>
References: <1238072077-27044-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<2a27d3730903270350m52fcb837ge78c0b87cc3887d5@mail.gmail.com>
	<OF073D5C49.F0D791DE-ONC1257586.0040163D-C1257586.00413F47@transmode.se>
Date: Mon, 30 Mar 2009 15:36:21 +0800
Message-ID: <2a27d3730903300036x1dc265a3o76ea36ca6a16fb5b@mail.gmail.com>
Subject: Re: [PATCH 1/2] ucc_geth: Move freeing of TX packets to NAPI context.
From: Li Yang <leoli@freescale.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 27, 2009 at 7:52 PM, Joakim Tjernlund
<Joakim.Tjernlund@transmode.se> wrote:
> pku.leo@gmail.com wrote on 27/03/2009 11:50:09:
>>
>> On Thu, Mar 26, 2009 at 8:54 PM, Joakim Tjernlund
>> <Joakim.Tjernlund@transmode.se> wrote:
>> > Also set NAPI weight to 64 as this is a common value.
>> > This will make the system alot more responsive while
>> > ping flooding the ucc_geth ethernet interaface.
>> >
>> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
>> > ---
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Errors and other events */
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ucce & UCCE_OTHER) {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ucce & UCC_=
GETH_UCCE_BSY)
>> > @@ -3733,7 +3725,7 @@ static int ucc_geth_probe(struct of_device*
> ofdev, const struct of_device_id *ma
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->netdev_ops =3D &ucc_geth_netdev_ops;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->watchdog_timeo =3D TX_TIMEOUT;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_WORK(&ugeth->timeout_work, ucc_geth_ti=
meout_work);
>> > - =C2=A0 =C2=A0 =C2=A0 netif_napi_add(dev, &ugeth->napi, ucc_geth_poll=
,
> UCC_GETH_DEV_WEIGHT);
>> > + =C2=A0 =C2=A0 =C2=A0 netif_napi_add(dev, &ugeth->napi, ucc_geth_poll=
, 64);
>>
>> It doesn't make sense to have larger napi budget than the size of RX
>> BD ring. =C2=A0You can't have more BDs than RX_BD_RING_LEN in backlog fo=
r
>> napi_poll to process. =C2=A0Increase the RX_BD_RING_LEN if you want to
>> increase UCC_GETH_DEV_WEIGHT. =C2=A0However please also provide the
>> performance comparison for this kind of change. =C2=A0Thanks
>
> Bring it up with David Miller. After my initial attempt to just increase
> weight somewhat, he requested that I hardcoded it to 64. Just read the
> whole thread.
> If I don't increase weight somewhat, ping -f -l 3 almost halts the board.
> Logging
> in takes forever. These are my "performance numbers".

Faster response time is surely good.  But it might also mean CPU is
not fully loaded.  IMHO, throughput is a more important factor for
network devices.  When you try to optimize the driver, please also
consider the throughput change.  Thanks.

- Leo
