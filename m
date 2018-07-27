Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cJSl4507zDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 16:09:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: John Allen <jallen@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH v07 2/9] hotplug/cpu: Add operation queuing function
In-Reply-To: <680c77f2-734c-aad5-03c6-5dbc92a0dedb@linux.vnet.ibm.com>
References: <a2c023e9-6997-d1a3-0110-fa8c788e64ee@linux.vnet.ibm.com>
 <71455ad3-482b-d801-8f2e-fa2ddcb4017f@linux.vnet.ibm.com>
 <680c77f2-734c-aad5-03c6-5dbc92a0dedb@linux.vnet.ibm.com>
Date: Fri, 27 Jul 2018 16:09:09 +1000
Message-ID: <87k1phyzui.fsf@concordia.ellerman.id.au>
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
> On 07/23/2018 12:51 PM, Nathan Fontenot wrote:
>> On 07/13/2018 03:18 PM, Michael Bringmann wrote:
...
>>> +
>>> +int dlpar_queued_actions_run(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 if (!list_empty(&dlpar_delayed_list)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pseries_hp_errorlog =
hp_errlog;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hp_errlog.resource =3D PSER=
IES_HP_ELOG_RESOURCE_PMT;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hp_errlog.action =3D 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hp_errlog.id_type =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_hotplug_event(&hp_err=
log, 0, 0); > +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>=20
>> I'm a bit confused by this. Is there a reason this needs to queue a
>> hotplug event instead of just walking the list as is done in dlpar_pmt?
>
> Up to this point, the operations have only been added to 'dlpar_delayed_l=
ist'.
> This function separates the execution of the CPU readd and Memory readd
> operations from the execution of 'migration store'.  If we walk the list
> here, then we add the execution time of all of the readd operations to
> the time of 'migration store'.  This is not a large problem in small
> systems like we have in the Kernel Team.  This may be a major issue thoug=
h,
> for production SAP HANA systems where we may be readding thousands of pag=
es
> of memory.  By pushing the execution of the CPU readd and Memory readd
> operations after, and separate, from the execution of 'migration store',
> we do not delay the end of the operation or the return of the completion
> status to an associated HMC.

But you can't return completion status, because the operation hasn't
completed.

The migration isn't finished until we've updated the topology for the
new system.

If you decouple things like this you now have no way of reporting
progress or an error to the caller.

So I'm unconvinced this is the right solution.

cheers
