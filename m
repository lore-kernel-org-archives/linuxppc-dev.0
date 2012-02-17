Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 833671007D8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 10:27:39 +1100 (EST)
Subject: Re: [PATCH 21/30] KVM: PPC: make e500v2 and e500mc mutually exclusive
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=iso-8859-1
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <CAOZdJXXxC5vdWrpz-sU0O+5oXS211DLYywqkQLwq0JOtRZyBHQ@mail.gmail.com>
Date: Sat, 18 Feb 2012 00:27:34 +0100
Message-Id: <52BB4C90-450E-41A1-82B5-EA04FADA8CE6@suse.de>
References: <1329497818-9729-1-git-send-email-agraf@suse.de>
 <1329497818-9729-22-git-send-email-agraf@suse.de>
 <CAOZdJXXxC5vdWrpz-sU0O+5oXS211DLYywqkQLwq0JOtRZyBHQ@mail.gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, list <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 17.02.2012, at 23:32, Tabi Timur-B04825 wrote:

> On Fri, Feb 17, 2012 at 10:56 AM, Alexander Graf <agraf@suse.de> =
wrote:
>=20
>>  config KVM_E500MC
>>        bool "KVM support for PowerPC E500MC/E5500 processors"
>> -       depends on EXPERIMENTAL && PPC_E500MC
>> +       depends on EXPERIMENTAL && PPC_E500MC && !KVM_E500V2
>=20
> There was a patch floating around that made a similar change to the
> platform support, so that you could either build an e500v2 kernel and
> enable support only for e500v2 board, or you could build an e500mc
> kernel and enable support only for e500mc boards.  Last I heard, the
> patch wasn't quite working, but that was a while ago.
>=20
> Is there a connection between this patch and that one?

No, and the code paths are quite orthogonal. While today it's impossible =
to build a kernel that can drive e500v2 and e500mc systems, it might be =
possible one day. That still doesn't buy us KVM compatibility between =
the two though. And vice versa. We could improve the KVM code to =
actually be versatile between the two platforms, but then you still =
couldn't run the same kernel on both ;).


Alex
