Return-Path: <wg@grandegger.com>
Message-ID: <49CA89BB.9090600@grandegger.com>
Date: Wed, 25 Mar 2009 20:44:59 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] powerpc: i2c-mpc: make I2C bus speed configurable
References: <49C151FF.1080604@grandegger.com>
	<fa686aa40903251116n2b7e8326r6c7cb9de8e101c76@mail.gmail.com>
In-Reply-To: <fa686aa40903251116n2b7e8326r6c7cb9de8e101c76@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> (cc'ing the devicetree-discuss mailing list)
> 
> On Wed, Mar 18, 2009 at 1:56 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> The I2C driver for the MPC still uses a fixed clock divider hard-coded
>> into the driver. This issue has already been discussed twice:
>>
>>  http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg21933.html
>>  http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg26923.html
>>
>> Let's code speak ;-). The attached RFC patch used the following approach:
>>
>> - the SOC property "i2c-clock-frequency" defines the frequency of the
>>  I2C source clock, which could be filled in by U-Boot. This avoids all
>>  the fiddling with getting the proper source clock frequency for the
>>  processor or board. I will provide a patch for U-Boot if this proposal
>>  gets accepted.
> 
> I'm not thrilled with this since it depends on u-boot being upgraded
> to work.  Actually, since this is an i2c only property, I don't think
> it belongs in the parent node at all.  The 'clock-frequency' property
> below is sufficient.  Having both seems to be two properties
> describing the exact same thing.

But it's not the same thing. The "i2c-clock-frequency" is the frequency
of the source clock distributed to the I2C devices and pends on the
processor type or even board. Deriving that frequency is tricky and
awkwards, e.g. have a look to u-boot/cpu/mpc85xx/speed.c to understand
what I mean. Maybe "i2c-source-clock-frequency" would be a more
appropriate name, though. As an alternative, we also discussed using a
divider property instead, e.g. "i2c-clock-divider" , which would not
depend on an up-to-date U-Boot version.

>> - the I2C node uses the property "clock-frequency" to define the desired
>>  I2C bus frequency. If 0, the FDR/DFSRR register already set by the
>>  bootloader will not be touched.
> 
> I like the property, but I don't like overloading the definition.  A
> value of 0 should be undefined and another property used
> ("fsl,preserve-clocking" perhaps?) to say that the FDR/DFSRR is
> already configured.

Fine for me. In fact, that's what we actually need ;-).

>> - I use Timur's divider table approach from U-Boot as it's more
>>  efficient than an appropriate algorithm (less code).
> 
> As I commented in the previous thread, I don't like the table approach
> and I'd rather see it done programmaticaly.  However, I'm not going to
> oppose the patch over this issue.  If it works and it doesn't mess up
> the dts binding then I'm happy.

Why should it mess up the dts binding? It's just the more efficient way
to implement it (less code). The result is the same. I will send some
figures tomorrow.

> But, it is cleaner and less complex if you use the of_match table
> .data element to select the correct setclock function.  Also makes it
> easier to handle setclock special cases as needed.

As you wrote in the a previous thread:

 http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg22368.html

This will work for most processors. Unfortunately for a few of them some
register setting must be checked as well, e.g. for the mpc8544 and the
table needs to be updated for each new MPC processor showing up. A SOC
property "i2c-clock-divider" would be more transparent and less
confusing. I'm personally not a friend of this magic fsl,mpcNNNN-deivce
compatibility property. It gets often added to the FDT nodes, but it's
rarely used by the Linux code.

>> - If none of the above new properties are defined, the old hard-coded
>>  FDR/DFSRR register settings are used for backward compatibility.
> 
> good
> 
>> What do you think? I'm still not happy that the tables and lookup
>> function are common code. But for the 82xx/85xx/86xx it's not obvious
>> to me where to put it.
> 
> I think it is just fine where it is.

OK.

Already the previous discussions showed that there are different
opinions :-(.

Wolfgang.
