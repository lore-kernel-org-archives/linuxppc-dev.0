Return-Path: <pku.leo@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id 89F0CDDDA9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 21:08:16 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c2so276261anc.39
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 04:08:13 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1240915882.15414.3.camel@localhost>
References: <2a27d3730904280316l7049bddbie914907b16ccfff6@mail.gmail.com>
	<1240913737-23773-1-git-send-email-leoli@freescale.com>
	<1240913737-23773-2-git-send-email-leoli@freescale.com>
	<1240913737-23773-3-git-send-email-leoli@freescale.com>
	<1240913737-23773-4-git-send-email-leoli@freescale.com>
	<1240913737-23773-5-git-send-email-leoli@freescale.com>
	<1240915882.15414.3.camel@localhost>
Date: Tue, 28 Apr 2009 19:08:13 +0800
Message-ID: <2a27d3730904280408j636d8e4tc1b6e1c827509379@mail.gmail.com>
Subject: Re: [PATCH] rio: warn_unused_result warnings fix
From: Li Yang <leoli@freescale.com>
To: michael@ellerman.id.au
Content-Type: text/plain; charset=UTF-8
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 28, 2009 at 6:51 PM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> On Tue, 2009-04-28 at 18:15 +0800, Li Yang wrote:
>> warning: ignoring return value of 'device_add', declared with attribute =
warn_unused_result
>> warning: ignoring return value of 'sysfs_create_bin_file', declared with=
 attribute warn_unused_result
>>
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> ---
>> =C2=A0drivers/rapidio/rio-scan.c =C2=A0| =C2=A0 =C2=A05 ++++-
>> =C2=A0drivers/rapidio/rio-sysfs.c | =C2=A0 =C2=A06 ++++--
>> =C2=A02 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
>> index 74d0bfa..9309e24 100644
>> --- a/drivers/rapidio/rio-scan.c
>> +++ b/drivers/rapidio/rio-scan.c
>> @@ -265,7 +265,10 @@ static void rio_route_set_ops(struct rio_dev *rdev)
>> =C2=A0 */
>> =C2=A0static void __devinit rio_add_device(struct rio_dev *rdev)
>> =C2=A0{
>> - =C2=A0 =C2=A0 device_add(&rdev->dev);
>> + =C2=A0 =C2=A0 int err;
>> +
>> + =C2=A0 =C2=A0 err =3D device_add(&rdev->dev);
>> + =C2=A0 =C2=A0 WARN_ON(err);
>>
>> =C2=A0 =C2=A0 =C2=A0 spin_lock(&rio_global_list_lock);
>> =C2=A0 =C2=A0 =C2=A0 list_add_tail(&rdev->global_list, &rio_devices);
>
> Is that really useful? Why not return the error to rio_setup_device()
> which can tell it's caller.

IMHO, when device_add() fails the system is quite broken.  So the
value is very limited for it to fail cleanly, which need some effort
to implement.  I can add it if you insist.

- Leo
