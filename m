Return-Path: <wg@grandegger.com>
Message-ID: <4B7B04EA.9010707@grandegger.com>
Date: Tue, 16 Feb 2010 21:49:46 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v7 1/4] i2c-mpc: use __devinit[data] for initialization
	functions and data
References: <1265813711-16794-1-git-send-email-wg@grandegger.com>
	<1265813711-16794-2-git-send-email-wg@grandegger.com>
	<fa686aa41002161040kada217ds1f63d363157e08ab@mail.gmail.com>
In-Reply-To: <fa686aa41002161040kada217ds1f63d363157e08ab@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ben Dooks <ben-linux@fluff.org>, Devicetree-discuss@lists.ozlabs.org,
	Linuxppc-dev@lists.ozlabs.org, Linux-i2c@vger.kernel.org,
	Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Wed, Feb 10, 2010 at 7:55 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> From: Wolfgang Grandegger <wg@denx.de>
>>
>> "__devinit[data]" has not yet been used for all initialization functions
>> and data. To avoid truncating lines, the struct "mpc_i2c_match_data" has
>> been renamed to "mpc_i2c_data", which is even the better name.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@denx.de>
>> Tested-by: Wolfram Sang <w.sang@pengutronix.de>
> 
> Between patch 1 & 2 is not bisectable.  Functions still called
> *_setclock in this patch, but referenced as *_setup in the structure.
> Please respin.

Argh, sorry for the mess. I will fix it tomorrow.

> Also ...
> 
>> +static struct mpc_i2c_data mpc_i2c_data_52xx __devinitdata = {
>> +       .setup = mpc_i2c_setup_52xx,
>> +};
>> +
>> +static struct mpc_i2c_data mpc_i2c_data_8313 __devinitdata = {
>> +       .setup = mpc_i2c_setup_8xxx,
>> +};
>> +
>> +static struct mpc_i2c_data mpc_i2c_data_8543 __devinitdata = {
>> +       .setup = mpc_i2c_setup_8xxx,
>> +       .prescaler = 2,
>> +};
>> +
>> +static struct mpc_i2c_data mpc_i2c_data_8544 __devinitdata = {
>> +       .setup = mpc_i2c_setup_8xxx,
>> +       .prescaler = 3,
>> +};
>> +
>>  static const struct of_device_id mpc_i2c_of_match[] = {
>> -       {.compatible = "mpc5200-i2c",
>> -        .data = &(struct mpc_i2c_match_data) {
>> -                       .setclock = mpc_i2c_setclock_52xx,
>> -               },
>> -       },
>> -       {.compatible = "fsl,mpc5200b-i2c",
>> -        .data = &(struct mpc_i2c_match_data) {
>> -                       .setclock = mpc_i2c_setclock_52xx,
>> -               },
>> -       },
>> -       {.compatible = "fsl,mpc5200-i2c",
>> -        .data = &(struct mpc_i2c_match_data) {
>> -                       .setclock = mpc_i2c_setclock_52xx,
>> -               },
>> -       },
>> -       {.compatible = "fsl,mpc8313-i2c",
>> -        .data = &(struct mpc_i2c_match_data) {
>> -                       .setclock = mpc_i2c_setclock_8xxx,
>> -               },
>> -       },
>> -       {.compatible = "fsl,mpc8543-i2c",
>> -        .data = &(struct mpc_i2c_match_data) {
>> -                       .setclock = mpc_i2c_setclock_8xxx,
>> -                       .prescaler = 2,
>> -               },
>> -       },
>> -       {.compatible = "fsl,mpc8544-i2c",
>> -        .data = &(struct mpc_i2c_match_data) {
>> -                       .setclock = mpc_i2c_setclock_8xxx,
>> -                       .prescaler = 3,
>> -               },
>> +       {.compatible = "mpc5200-i2c", .data = &mpc_i2c_data_52xx, },
>> +       {.compatible = "fsl,mpc5200b-i2c", .data = &mpc_i2c_data_52xx, },
>> +       {.compatible = "fsl,mpc5200-i2c", .data = &mpc_i2c_data_52xx, },
>> +       {.compatible = "fsl,mpc8313-i2c", .data = &mpc_i2c_data_8313, },
>> +       {.compatible = "fsl,mpc8543-i2c", .data = &mpc_i2c_data_8543, },
>> +       {.compatible = "fsl,mpc8544-i2c", .data = &mpc_i2c_data_8544, },
> 
> ... what was wrong with the old format of declaring the .data
> structures inline with the match table?

It does not allow to use __devinitdata because the space reserved by the
compiler does belong to another section. In other words it was necessary
to get ride of section mismatches.

Wolfgang.
