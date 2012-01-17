Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 81A811007D4
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jan 2012 23:19:24 +1100 (EST)
Subject: Re: [RFC PATCH 1/2] KVM: PPC: Book3S HV: Make virtual processor area
 registration more robust
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20120117113140.GA9093@bloggs.ozlabs.ibm.com>
Date: Tue, 17 Jan 2012 13:19:14 +0100
Message-Id: <10F7042F-3E8C-485D-AF5F-7B6441CADC66@suse.de>
References: <20111220102142.GB5626@bloggs.ozlabs.ibm.com>
 <20111220102257.GC5626@bloggs.ozlabs.ibm.com>
 <1A57B98F-A4C7-457D-A52A-4F67D5902E32@suse.de> <20120117055654.GB9170@drongo>
 <6D049B19-8A91-445A-9FBB-E4851D4F586E@suse.de>
 <20120117113140.GA9093@bloggs.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 17.01.2012, at 12:31, Paul Mackerras wrote:

> On Tue, Jan 17, 2012 at 10:27:26AM +0100, Alexander Graf wrote:
>=20
>> The thing I was getting at was not the map during the lifetime, but
>> the map during registration. Currently we have:
>>=20
>> 1) Set VPA to x
>> 2) Assign feature y to VPA
>> 3) Use VPA
>>=20
>> 1 and 2 are the slow path, 3 occurs more frequently. So we want 3 to
>> be fast. 1 and 2 don't matter that much wrt performance.
>>=20
>> You are currently mapping the VPA at /, which gets you into this
>> map/unmap mess trying to free the previous mapping. If you moved the
>> map to step 2 and only stored the GPA at step 1, all map+unmap
>> operations except for final unmaps would be in one spot, so you
>> wouldn't need to construct this big complex state machine.
>=20
> That might simplify things - I'll try it and see.  The worry with
> doing the map/pin at 2 is that if anything goes wrong we no longer
> have the opportunity to return an error for the H_REGISTER_VPA call,
> so I'll have to at least do some checking in 1, leading to possibly
> more code overall.

Well, then map and unmap it in step 1 and map it in step 2 again. We're =
in the slow path so performance isn't critical. Readability and =
maintainability however are :)


Alex
