Return-Path: <clg@fr.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F1111A0AB1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 04:04:12 +1000 (AEST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Tue, 7 Apr 2015 19:04:09 +0100
Message-ID: <55241C02.60103@fr.ibm.com>
Date: Tue, 07 Apr 2015 20:03:46 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4/4] hwmon: (ibmpowernv) pretty print labels
References: <5523ECC4.9010609@fr.ibm.com>
 <1428417956-28617-1-git-send-email-clg@fr.ibm.com>
 <20150407164439.GA4514@roeck-us.net>
In-Reply-To: <20150407164439.GA4514@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Guenter,

On 04/07/2015 06:44 PM, Guenter Roeck wrote:
> On Tue, Apr 07, 2015 at 04:45:56PM +0200, Cédric Le Goater wrote:
>> The new OPAL device tree adds a few properties which can be used to add
>> extra information on the sensor label.
>>
>> In the case of a cpu core sensor, the firmware exposes the physical 
>> identifier of the core in the "ibm,pir" property. The driver 
>> translates this identifier in a linux cpu number and prints out a 
>> range corresponding to the hardware threads of the core (as they
>> share the same sensor).
>>
>> The numbering gives a hint on the localization of the core in the 
>> system (which socket, which chip). 
>>
>> Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
> 
> Hi Cedric,
> 
> Please do not send follow-up patches as reply, but as separate e-mail.

Ok. I will start a new thread when I resend this patch.

> Further comments below.
> 
>> ---
>>
>>  Changes since v1:
>>
>>  - check cpu validity before printing out the attribute label. 
>>    if invalid, use a "phy" prefix to distinguish a linux cpu 
>>    number from a physical cpu number. 
>>
>>  drivers/hwmon/ibmpowernv.c |   34 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> Index: linux.git/drivers/hwmon/ibmpowernv.c
>> ===================================================================
>> --- linux.git.orig/drivers/hwmon/ibmpowernv.c
>> +++ linux.git/drivers/hwmon/ibmpowernv.c
>> @@ -113,9 +113,43 @@ static ssize_t show_label(struct device
>>  static void __init make_sensor_label(struct device_node *np,
>>  		    struct sensor_data *sdata, const char *label)
>>  {
>> +	u32 id;
>>  	size_t n;
>>  
>>  	n = snprintf(sdata->label, sizeof(sdata->label), "%s", label);
>> +
>> +	/*
>> +	 * Core temp pretty print
>> +	 */
>> +	if (!of_property_read_u32(np, "ibm,pir", &id)) {
>> +		int i = -1;
>> +
>> +		for_each_possible_cpu(i)
>> +			if (paca[i].hw_cpu_id == id)
> 
> I think you should consider using get_hard_smp_processor_id() and avoid
> direct access to the paca array.

Yes. It will look better. Thanks.

>> +				break;
>> +
>> +		if (i != -1)
> 
> I don't think that works. i is initialized by for_each_possible_cpu(),
> either to -1 or 0 depending on the state of CONFIG_SMP. So pre-initializing
> it won't make a difference. Its last value is NR_CPUS (SMP) or 1 (non-SMP).
> 
> You would need a second variable (which you could pre-initialize)
> to determine if the code found a matching ID or not.

gloups. I did that patch waaaay too quickly, it is completely bogus ... 
I will cook a new version. sorry for the noise. 

>> +			/*
>> +			 * The digital thermal sensors are associated
>> +			 * with a core. Let's print out the range of
>> +			 * cpu ids corresponding to the hardware
>> +			 * threads of the core.
>> +			 */
>> +			n += snprintf(sdata->label + n,
>> +				      sizeof(sdata->label) - n,
>> +				      " %d-%d", i, i+7);
> 
> I would really like to see how this looks like in practice.
> 
> The id in the devicetree entry is the physical CPU. The resulting index
> is the logical CPU number. So let's assume that the logical CPU number
> for the first physical CPU is 0. Output would be "0-7". If the second
> physical CPU matches logical CPU 1, output would be "1-8". 
> How does that make any sense ?

The logical CPU numbers on PowerPC are initialized looping on the cores
found in the device tree and then on the threads of the core. Something 
like :

	logical_cpu = core_index * max_threads_per_core + thread_index 

which gives on a P8  :

	# ppc64_cpu --info
	Core   0:    0*    1*    2*    3*    4*    5*    6*    7* 
	Core   1:    8*    9*   10*   11*   12*   13*   14*   15* 
	Core   2:   16*   17*   18*   19*   20*   21*   22*   23* 
	Core   3:   24*   25*   26*   27*   28*   29*   30*   31* 
	Core   4:   32*   33*   34*   35*   36*   37*   38*   39* 
	Core   5:   40*   41*   42*   43*   44*   45*   46*   47* 
	Core   6:   48*   49*   50*   51*   52*   53*   54*   55* 
	Core   7:   56*   57*   58*   59*   60*   61*   62*   63* 
	Core   8:   64*   65*   66*   67*   68*   69*   70*   71* 
	Core   9:   72*   73*   74*   75*   76*   77*   78*   79* 
	Core  10:   80*   81*   82*   83*   84*   85*   86*   87* 
	Core  11:   88*   89*   90*   91*   92*   93*   94*   95* 
	Core  12:   96*   97*   98*   99*  100*  101*  102*  103* 
	Core  13:  104*  105*  106*  107*  108*  109*  110*  111* 
	Core  14:  112*  113*  114*  115*  116*  117*  118*  119* 
	Core  15:  120*  121*  122*  123*  124*  125*  126*  127* 
	Core  16:  128*  129*  130*  131*  132*  133*  134*  135* 
	Core  17:  136*  137*  138*  139*  140*  141*  142*  143* 
	Core  18:  144*  145*  146*  147*  148*  149*  150*  151* 
	Core  19:  152*  153*  154*  155*  156*  157*  158*  159* 

on a P7  :

	# ppc64_cpu --info
	Core   0:    0*    1*    2*    3* 
	Core   1:    4*    5*    6*    7* 
	Core   2:    8*    9*   10*   11* 
	Core   3:   12*   13*   14*   15* 
	Core   4:   16*   17*   18*   19* 
	Core   5:   20*   21*   22*   23* 


> Also, how do you know that the range of CPU IDs is always 8 ?

This is a shortcut. The code is for the ibmpowernv platform and assumes 
that we are running on a P8 (8 hardware threads). It would be better to 
use a "maximum threads per core" variable but I am not sure this is 
available, as it is a tunable. I will look into it.

> Can you provide some resulting outputs ?

sure. 

On an Open Power system : 

	# sensors
	ibmpowernv-isa-0000
	Adapter: ISA adapter
	Core 8-15:    +29.0°C  
	Core 16-23:   +29.0°C  
	Core 24-31:   +30.0°C  
	Core 32-39:   +30.0°C  
	Core 40-47:   +32.0°C  
	Core 48-55:   +29.0°C  
	Core 56-63:   +29.0°C  
	Centaur 0:    +28.0°C  
	Centaur 1:    +32.0°C  
	Centaur 4:    +28.0°C  
	Centaur 5:    +27.0°C  
	Core 0-7:     +29.0°C  

The Centaur numbering does not look as good as for the core.

On an IBM Power system :

	# sensors
	ibmpowernv-isa-0000
	Adapter: ISA adapter
	fan1:         5960 RPM  (min =    0 RPM)
	fan2:         5252 RPM  (min =    0 RPM)
	fan3:         5960 RPM  (min =    0 RPM)
	fan4:         5242 RPM  (min =    0 RPM)
	fan5:         5008 RPM  (min =    0 RPM)
	fan6:         5000 RPM  (min =    0 RPM)
	fan7:         5232 RPM  (min =    0 RPM)
	fan8:         5986 RPM  (min =    0 RPM)
	fan9:         5232 RPM  (min =    0 RPM)
	fan10:        6094 RPM  (min =    0 RPM)
	fan11:        5242 RPM  (min =    0 RPM)
	fan12:        5882 RPM  (min =    0 RPM)
	fan13:        5212 RPM  (min =    0 RPM)
	fan14:        5973 RPM  (min =    0 RPM)
	Ambient:       +18.0°C  (high =  +0.0°C)
	Core 0-7:      +40.0°C  
	Core 8-15:     +39.0°C  
	Core 16-23:    +39.0°C  
	Core 24-31:    +38.0°C  
	Core 32-39:    +38.0°C  
	Core 40-47:    +37.0°C  
	Core 48-55:    +37.0°C  
	Core 56-63:    +38.0°C  
	Core 64-71:    +38.0°C  
	Core 72-79:    +39.0°C  
	Core 80-87:    +35.0°C  
	Core 88-95:    +34.0°C  
	Core 96-103:   +33.0°C  
	Core 104-111:  +34.0°C  
	Core 112-119:  +33.0°C  
	Core 120-127:  +31.0°C  
	Core 128-135:  +31.0°C  
	Core 136-143:  +39.0°C  
	Core 144-151:  +39.0°C  
	Core 152-159:  +40.0°C  
	power1:       425.00 W  

The Centaur are not exposed yet.

Thanks,

C.
