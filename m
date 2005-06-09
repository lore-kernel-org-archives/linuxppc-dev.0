Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 7CD0A67B3C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 05:06:55 +1000 (EST)
Message-ID: <42A89338.209@mvista.com>
Date: Thu, 09 Jun 2005 12:06:32 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
References: <42A0CD46.60300@mvista.com>	<20050603214653.GA15314@gate.ebshome.net>	<42A0D714.1050601@mvista.com>
	<20050609192551.76b103ea.khali@linux-fr.org>
In-Reply-To: <20050609192551.76b103ea.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: LM@ozlabs.org, linuxppc-embedded@ozlabs.org,
	Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] Re: [PATCH 1/2] Add support for Maxim/Dallas DS1374
 Real-Time Clock Chip
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jean,

Jean Delvare wrote:

>Hi Randy and all,
>
>Sorry for the delay.
>
>[Eugene Surovegin]
>  
>
>>I wonder, why you chose to use those 1-byte SMBus transfers instead
>>of  i2c transfer.
>>    
>>
>
>[Randy Vinson]
>  
>
>>I was simply following the guidelines in 
>>Documentation/i2c/writing-clients as noted in the driver header. This 
>>note was in the driver I used as my base, so I just followed along.
>>    
>>
>
>The document file says:
>
>"If you can choose between plain i2c communication and SMBus level
>communication, please use the last. All adapters understand SMBus level
>commands, but only some of them understand plain i2c!"
>
>The "if you can choose" is important. It doesn't suggest that you should
>use a less efficient way, but that you use the SMBus API when the I2C
>transfer you want to use happens to exist in the SMBus API.
>
>Even when sticking to SMBus commands, it is quite frequent that there
>are different ways to retrieve the same information, of varying
>availability and speed. One good example of this are EEPROMs. EEPROMs
>are I2C devices which can be accessed using SMBus commands. You can read
>bytes one by one (SMBus Read Byte Data command), or continuously as
>different reads (first one SMBus Write Byte, then many SMBus Read Byte),
>or continuously as a single read (I2C Block Read, supported by some
>SMBus controllers). If you look at the eeprom.c drivers, you'll see that
>the second and the third method are both implemented. The advantage is
>that:
>

I interpreted the doc the same way Randy did when I did the m41t00 chip 
code.  Also, Mark Studebaker seemed to support that interpretation in 
this email: http://archives.andrew.net.au/lm-sensors/msg29325.html

I suppose the best thing to do is check if the adapter is a true i2c 
ctlr (something like: i2c_check_functionality(adapter, I2C_FUNC_I2C)) 
and base the cmds used on that.

We can do something similar with I2C_FUNC_SMBUS_READ_I2C_BLOCK & 
I2C_FUNC_SMBUS_WRITE_BLOCK_DATA to check if we can use the smbus block 
cmds too, correct?

Mark
