Return-Path: <alex_rosenberg@playstation.sony.com>
In-Reply-To: <20060519081654.GB22952@iram.es>
References: <1148011621.13249.7.camel@localhost.localdomain>
	<20060519081654.GB22952@iram.es>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <995508C0-6D30-479A-8ED5-C28CC0143DB7@playstation.sony.com>
From: Alex Rosenberg <alex_rosenberg@playstation.sony.com>
Subject: Re: [Cbe-oss-dev] Cell and new CPU feature bits
Date: Mon, 22 May 2006 12:46:23 -0700
To: Gabriel Paubert <paubert@iram.es>
Cc: cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On May 19, 2006, at 1:16 AM, Gabriel Paubert wrote:

> On Fri, May 19, 2006 at 02:07:01PM +1000, Benjamin Herrenschmidt  
> wrote:
>> The Cell has a couple of "features" that should be exposed to  
>> userland
>> in a way or another. That raises some questions however about how  
>> those
>> should be done. Among others that come to mind:
>>
>>  - The timebase errata (should we use a separate aux vector for  
>> "bugs"
>> than for "features" ?
>
> Is this bug really going to be exposed in the wild or is it
> an early silicon bug that will only bite early-testers?

Is this or any other errata published somewhere? I didn't think they  
were.

>>  - Additional Altivec instructions (load/store right/left). A new
>> feature bit for these ?
>
> Yes. So IBM was not happy with Altivec instructions to generate
> vsel control words and got their inspiration from MIPS?

I think you can blame Waternoose for this, not Cell.

>>  - Not strictly Cell specific but we currently don't expose the  
>> support
>> for optional instructions
>>    fres and frsqte (which are supported by Cell)
>
> Should be exposed IMHO. But these instructions have been present
> in a lot of PPC processors AFAIR, they are in my original 603 and
> 604 manuals from 1994 (fsel is also marked as optional and is not
> implemented on the 601, but I'm not sure it's really supported
> anymore). I don't know about Power processors.

Our solution back at Apple was to put OF properties on the CPU node  
for each optional feature. e.g. for fres and frsqrte we put  
"graphics" since that's the official term for that group of optional  
instructions. We also put in "data-streams" instead of presuming that  
dss, etc. were always part of "altivec". These properties nicely fit  
into our Gestalt() API where "ppcf" had 32 bits to describe these to  
userland software.

-----------------------------------------
Alex Rosenberg
Runtime Lead, Tools & Technology team
Sony Computer Entertainment America, Inc.
