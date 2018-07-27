Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cJCb6NH0zDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 15:57:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 John Allen <jallen@linux.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>
Subject: Re: [PATCH v07 2/9] hotplug/cpu: Add operation queuing function
In-Reply-To: <0bcf83ad-0d06-2311-e9c6-cd66326b5f93@linux.vnet.ibm.com>
References: <458ff569-f611-f506-afa1-138146551dde@linux.vnet.ibm.com>
 <a2c023e9-6997-d1a3-0110-fa8c788e64ee@linux.vnet.ibm.com>
 <20180723155414.2apx5uxrn3462qks@p50>
 <0bcf83ad-0d06-2311-e9c6-cd66326b5f93@linux.vnet.ibm.com>
Date: Fri, 27 Jul 2018 15:57:47 +1000
Message-ID: <87muudz0dg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
> On 07/23/2018 10:54 AM, John Allen wrote:
>> On Fri, Jul 13, 2018 at 03:18:01PM -0500, Michael Bringmann wrote:
>>> @@ -407,6 +413,61 @@ void queue_hotplug_event(struct pseries_hp_errorlo=
g *hp_errlog,
...
>>> +
>>> +static int dlpar_pmt(struct pseries_hp_errorlog *work)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct list_head *pos, *q;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ssleep(15);
>>=20
>> Why do we need to sleep for so long here?
>
> One or more drivers were finishing their initialization about the same
> time as the 'migration_store' operation was completing.  E.g. 'ibmvscsi'
> When we did 'dlpar cpu readd' operations at the same time early on in
> testing, the errors / warnings were inconsistent.  I put in a delay to
> get beyond the driver re-init after migration.  15 seconds was an estimat=
e.
> As it occurs after the completion of the 'migration store' operation,
> it does not delay any responses returned to the HMC.
>
> We can rerun tests with reduced / removed delays to see if they are still
> necessary given some other corrections in the mix.

Please do.

I'm not inclined to merge code with "sleep 15" in it, unless there's
some incredibly good reason for it.

cheers
