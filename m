Return-Path: <sachin.surendran@gmail.com>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D30432C0087
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 09:58:13 +1100 (EST)
Received: by mail-vb0-f51.google.com with SMTP id fq11so6617522vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Nov 2012 14:58:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <B8BB551F-BD07-41A9-BCA6-7451C3D12CAA@kernel.crashing.org>
References: <CABCb4NUJ0uJA5Z9vdgLndvpLrnK=m5xaeiHZxAwHKFU2DroaFw@mail.gmail.com>
 <B8BB551F-BD07-41A9-BCA6-7451C3D12CAA@kernel.crashing.org>
From: sachin surendran <sachin.surendran@gmail.com>
Date: Mon, 26 Nov 2012 11:57:29 +1300
Message-ID: <CABCb4NXvdmSasctRB8XBK1SsJDoz0cou0XyQJVPO9UvoZRZ21Q@mail.gmail.com>
Subject: Re: [PATCH] i2c-cpm: Fix to takeback i2c bus master-ship after a
 collision
To: Kumar Gala <galak@kernel.crashing.org>
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

Hi Kumar,
             I have resent the updated patch.

Regards
Sachin

On Mon, Nov 26, 2012 at 2:21 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Oct 30, 2012, at 10:00 PM, sachin surendran wrote:
>
>> In case of collision on i2c bus the controller which lost bus mastership stays as a slave
>> for all subsequent transfers. This results in the i2c controller never writing to the bus
>> for future transactions, resulting in i2c transfer timeouts.
>>   This fix checks for a collision on last I2C transaction and sets the I2COM_MASTER
>> bit for the new transaction.
>>
>> Signed-off-by: Sachin Surendran <sachin.surendran@alliedtelesis.co.nz>
>> ---
>>  drivers/i2c/busses/i2c-cpm.c |    8 ++++++++
>>  1 file changed, 8 insertions(+)
>
> patch doesn't apply, please resend properly.
>
> - k
>
>>
>> diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
>> index c1e1096..bb94c6d 100644
>> --- a/drivers/i2c/busses/i2c-cpm.c
>> +++ b/drivers/i2c/busses/i2c-cpm.c
>> @@ -338,6 +338,14 @@ static int cpm_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>>         tptr = 0;
>>         rptr = 0;
>>
>> +       /*
>> +        * If there was a collision in the last i2c transaction,
>> +        * Set I2COM_MASTER as it was cleared during collision.
>> +        */
>> +       if (in_be16(&tbdf->cbd_sc) & BD_SC_CL) {
>> +               out_8(&cpm->i2c_reg->i2com, I2COM_MASTER);
>> +       }
>> +
>>         while (tptr < num) {
>>                 pmsg = &msgs[tptr];
>>                 dev_dbg(&adap->dev, "R: %d T: %d\n", rptr, tptr);
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
