Return-Path: <wg@grandegger.com>
Message-ID: <4B7285D5.9060008@grandegger.com>
Date: Wed, 10 Feb 2010 11:09:25 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v4 1/3] i2c-mpc: use __devinit[data] for initialization
	functions and data
References: <1264685141-26391-1-git-send-email-wg@grandegger.com>
	<1264685141-26391-2-git-send-email-wg@grandegger.com>
	<fa686aa41002090941je3e4fdqbecf2616a8b90e42@mail.gmail.com>
In-Reply-To: <fa686aa41002090941je3e4fdqbecf2616a8b90e42@mail.gmail.com>
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
> On Thu, Jan 28, 2010 at 6:25 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> From: Wolfgang Grandegger <wg@denx.de>
>>
>> "__devinit[data]" has not yet been used for all initialization functions
>> and data. To avoid truncating lines, the struct "mpc_i2c_match_data" has
>> been renamed to "mpc_i2c_data", which is even the better name.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@denx.de>
> 
> Several comments below.
> 
>> ---
>>  drivers/i2c/busses/i2c-mpc.c |  103 +++++++++++++++++++----------------------
>>  1 files changed, 48 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
>> index f627001..275ebe6 100644
>> --- a/drivers/i2c/busses/i2c-mpc.c
>> +++ b/drivers/i2c/busses/i2c-mpc.c
>> @@ -66,7 +66,7 @@ struct mpc_i2c_divider {
>>        u16 fdr;        /* including dfsrr */
>>  };
>>
>> -struct mpc_i2c_match_data {
>> +struct mpc_i2c_data {
>>        void (*setclock)(struct device_node *node,
>>                         struct mpc_i2c *i2c,
>>                         u32 clock, u32 prescaler);
>> @@ -165,7 +165,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
>>  }
>>
>>  #ifdef CONFIG_PPC_MPC52xx
>> -static const struct mpc_i2c_divider mpc_i2c_dividers_52xx[] = {
>> +static const struct __devinitdata mpc_i2c_divider mpc_i2c_dividers_52xx[] = {
> 
> __devinitdata goes at the end, immediately before the '='.  Ditto
> throughout the file.

This made a difference and revealed section mismatches. "const" seems to
be incompatible with "__devinitdata".

>>        {20, 0x20}, {22, 0x21}, {24, 0x22}, {26, 0x23},
>>        {28, 0x24}, {30, 0x01}, {32, 0x25}, {34, 0x02},
>>        {36, 0x26}, {40, 0x27}, {44, 0x04}, {48, 0x28},
>> @@ -582,44 +584,35 @@ static int __devexit fsl_i2c_remove(struct of_device *op)
>>        return 0;
>>  };
>>
>> +static struct mpc_i2c_data __devinitdata mpc_i2c_data_52xx = {
>> +       .setclock = mpc_i2c_setclock_52xx,
>> +};
>> +
>> +static struct mpc_i2c_data __devinitdata mpc_i2c_data_8313 = {
>> +       .setclock = mpc_i2c_setclock_8xxx,
>> +};
>> +
>> +static struct mpc_i2c_data __devinitdata mpc_i2c_data_8543 = {
>> +       .setclock = mpc_i2c_setclock_8xxx,
>> +       .prescaler = 2,
>> +};
>> +
>> +static struct mpc_i2c_data __devinitdata mpc_i2c_data_8544 = {
>> +       .setclock = mpc_i2c_setclock_8xxx,
>> +       .prescaler = 3,
>> +};
>> +
>>  static const struct of_device_id mpc_i2c_of_match[] = {
> 
> You can make this __devinitdata too.

This results in a section mismatch as it's referenced by fsl_i2c_init().
I just sent out v6. Hope it's OK now.

Thanks,

Wolfgang.
