Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D3F3D2C00E5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2013 05:22:55 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 5 Apr 2013 14:22:52 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 73D2738C807F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2013 14:22:44 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r35IMiaI306434
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Apr 2013 14:22:44 -0400
Received: from d01av05.pok.ibm.com (loopback [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r35IMi9Z026091
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Apr 2013 14:22:44 -0400
Message-ID: <515F1673.7040304@linux.vnet.ibm.com>
Date: Fri, 05 Apr 2013 13:22:43 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 7/11] Use stop machine to update cpu maps
References: <51509AE8.8070803@linux.vnet.ibm.com>
 <51509E3C.2030008@linux.vnet.ibm.com> <20130404044654.GH19443@drongo>
In-Reply-To: <20130404044654.GH19443@drongo>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/03/2013 11:46 PM, Paul Mackerras wrote:
> On Mon, Mar 25, 2013 at 01:58:04PM -0500, Nathan Fontenot wrote:
>> From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
>>
>> The new PRRN firmware feature allows CPU and memory resources to be
>> transparently reassigned across NUMA boundaries. When this happens, the
>> kernel must update the node maps to reflect the new affinity
>> information.
>>
>> Although the NUMA maps can be protected by locking primitives during the
>> update itself, this is insufficient to prevent concurrent accesses to these
>> structures. Since cpumask_of_node() hands out a pointer to these
>> structures, they can still be modified outside of the lock. Furthermore,
>> tracking down each usage of these pointers and adding locks would be quite
>> invasive and difficult to maintain.
>>
>> Situations like these are best handled using stop_machine(). Since the NUMA
>> affinity updates are exceptionally rare events, this approach has the
>> benefit of not adding any overhead while accessing the NUMA maps during
>> normal operation.
> 
> I notice you do one stop_machine() call for every cpu whose affinity
> has changed.  Couldn't we update the affinity for them all in one
> stop_machine call?  Given that stopping the whole machine can be quite
> slow, wouldn't it be better to do one call rather than potentially
> many?
> 

Agreed, having to call stop_machine() for each cpu that gets updated is
pretty brutal. The plus side is that PRRN events should a rare occurrence 
and not cause too much pain.

The current design ties into the of notification chain so that we can do
the affinity update when the affinity property in the device tree is updated.
Switching to doing one stop and updating all of the cpus would require a
design change....and....

I went back and looked at the code again and there is another issue with
way this is done. Tying into the of notification chain is great for
being informed of when a property changes but the code (from patch 6/11)

+	case OF_RECONFIG_ADD_PROPERTY:
+	case OF_RECONFIG_UPDATE_PROPERTY:
+		update = (struct of_prop_reconfig *)data;
+		if (!of_prop_cmp(update->dn->type, "cpu")) {
+			u32 core_id;
+			of_property_read_u32(update->dn, "reg", &core_id);
+			stage_topology_update(core_id);
+			rc = NOTIFY_OK;
+		}
+		break;

Does not check to see which property is being updated and just assumes
the affinity is being updated. This code as is will do an affinity update
every time any property of a cpu is updated or added.

Since this needs an update I will also look at possibly doing this so
that we call stop_machine only once.

-- 
-Nathan
