Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181]) by ozlabs.org (Postfix) with ESMTP id 24156B7D5A
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 12:53:23 +1100 (EST)
Received: by ywh11 with SMTP id 11so132562ywh.9
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 17:53:22 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <ad1b9321-b7ad-47a6-93ca-ca260ff2a66d@SG2EHSMHS011.ehs.local>
References: <2ea396ca-3014-40f4-86ac-0e9f1aa82b5b@SG2EHSMHS005.ehs.local>
	<1d3f23371002091430hb550153u602c8e7c010381b9@mail.gmail.com>
	<ad1b9321-b7ad-47a6-93ca-ca260ff2a66d@SG2EHSMHS011.ehs.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 18:53:01 -0700
Message-ID: <fa686aa41002091753n36c59e3brd2b2174035e4933d@mail.gmail.com>
Subject: Re: [PATCH] [V3] net: emaclite: adding MDIO and phy lib support
To: John Linn <John.Linn@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Sadanand Mutyala <sadanan@xilinx.com>, jgarzik@pobox.com,
	John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 9, 2010 at 4:00 PM, John Linn <John.Linn@xilinx.com> wrote:
>> -----Original Message-----
>> From: John Williams [mailto:john.williams@petalogix.com]
>> Sent: Tuesday, February 09, 2010 3:30 PM
>> To: John Linn
>> Cc: netdev@vger.kernel.org; linuxppc-dev@ozlabs.org; jgarzik@pobox.com; =
grant.likely@secretlab.ca;
>> jwboyer@linux.vnet.ibm.com; Sadanand Mutyala
>> Subject: Re: [PATCH] [V3] net: emaclite: adding MDIO and phy lib support
>>
>> Hi John,
>>
>> Sorry If I'm painting bike-sheds here, just one tiny tweak might be in
>> order to standardise your mutex_unlock exit path:
>>
>> > +static int xemaclite_mdio_read(struct mii_bus *bus, int phy_id, int r=
eg)
>> > +{
>> > + =A0 =A0 =A0 struct net_local *lp =3D bus->priv;
>> > + =A0 =A0 =A0 u32 ctrl_reg;
>> > + =A0 =A0 =A0 u32 rc;
>> > +
>> > + =A0 =A0 =A0 mutex_lock(&lp->mdio_mutex);
>> > +
>> > + =A0 =A0 =A0 if (xemaclite_mdio_wait(lp)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&lp->mdio_mutex);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> > + =A0 =A0 =A0 }
>>
>> [snip]
>>
>>
>> > + =A0 =A0 =A0 if (xemaclite_mdio_wait(lp)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&lp->mdio_mutex);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
>> > + =A0 =A0 =A0 }
>>
>> [snip]
>>
>>
>> > + =A0 =A0 =A0 dev_dbg(&lp->ndev->dev,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "xemaclite_mdio_read(phy_id=3D%i, reg=3D=
%x) =3D=3D %x\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_id, reg, rc);
>> > +
>> > + =A0 =A0 =A0 return rc;
>>
>> Can this be better expressed like this:
>>
>> my_func() {
>> =A0 mutex_lock()
>> ..
>>
>> =A0 if(some error) {
>> =A0 =A0 rc=3D-ETIMEDOUT;
>> =A0 =A0 goto out_unlock;
>> =A0 }
>> =A0 ...
>>
>> =A0 /* success path */
>> =A0 rc=3D0;
>> ..
>> out_unlock:
>> =A0 mutex_unlock()
>> =A0 return rc;
>> }
>>
>>
>> Is this style still favoured in driver exit paths?
>
> It looks to me like the mutex is not needed in the driver mdio functions =
as there's a mutex in the mdiobus functions already.

Yes, you're correct, but you still need to protect against direct
calls to the read/write routines from within the driver.  But you can
probably use the mdio_lock mutex for this.

g.
