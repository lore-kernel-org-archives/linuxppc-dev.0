Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 63E96B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Jul 2010 19:15:34 +1000 (EST)
Subject: Re: [PATCH 27/27] KVM: PPC: Add Documentation about PV interface
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <AANLkTil6RekYBNnpM2MjSH7rcrHQZdHRwK5cBrvKQKhM@mail.gmail.com>
Date: Fri, 9 Jul 2010 11:15:28 +0200
Message-Id: <B3EA423C-6CAA-430C-BC12-86153B6EC98D@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-28-git-send-email-agraf@suse.de>
	<AANLkTil6RekYBNnpM2MjSH7rcrHQZdHRwK5cBrvKQKhM@mail.gmail.com>
To: MJ embd <mj.embd@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 09.07.2010, at 11:11, MJ embd wrote:

> On Thu, Jul 1, 2010 at 4:13 PM, Alexander Graf <agraf@suse.de> wrote:
>> We just introduced a new PV interface that screams for documentation. =
So here
>> it is - a shiny new and awesome text file describing the internal =
works of
>> the PPC KVM paravirtual interface.
>>=20
>> Signed-off-by: Alexander Graf <agraf@suse.de>
>>=20
>> +
>> +
>> +Some instructions require more logic to determine what's going on =
than a load
>> +or store instruction can deliver. To enable patching of those, we =
keep some
>> +RAM around where we can live translate instructions to. What happens =
is the
>> +following:
>> +
>> +       1) copy emulation code to memory
>> +       2) patch that code to fit the emulated instruction
>> +       3) patch that code to return to the original pc + 4
>> +       4) patch the original instruction to branch to the new code
>> +
>> +That way we can inject an arbitrary amount of code as replacement =
for a single
>> +instruction. This allows us to check for pending interrupts when =
setting EE=3D1
>> +for example.
>> +
>=20
> Which patch does this mapping ? Can you please point to that.

The branch patching is in patch 22/27. For the respective users, see =
patch 23-26/27.


Alex
