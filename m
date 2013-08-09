Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 649E92C0089
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Aug 2013 20:14:06 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Fri, 9 Aug 2013 20:10:56 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 795C13578050
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Aug 2013 20:14:02 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r799w9od55967880
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Aug 2013 19:58:10 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r79AE1N9015459
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Aug 2013 20:14:01 +1000
Message-ID: <5204C0E4.8070905@linux.vnet.ibm.com>
Date: Fri, 09 Aug 2013 15:43:56 +0530
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH 00/11] Add compression support to pstore
References: <20130715164844.1520.27771.stgit@aruna-ThinkPad-T420>
 <51FA3B02.7060004@linux.vnet.ibm.com>
 <3908561D78D1C84285E8C5FCA982C28F31CAA167@ORSMSX106.amr.corp.intel.com>
 <CA+8MBbLuhVDCb26ag3AH0vXrP4MXHLxS5aVn8pTi4=qL1NdR5w@mail.gmail.com>
 <CA+8MBbJ7x46FGC7dPSdNzf8z=fZz20w1kiNgnZr4QQB6SUELhg@mail.gmail.com>
 <51FFDC8B.7010909@linux.vnet.ibm.com>
 <CA+8MBb+1LpR+Cx=84WZT98U5eqZcm1KriUP75aCg+uSrXrb3Yw@mail.gmail.com>
 <51FFFFEB.3030907@linux.vnet.ibm.com>
 <CA+8MBbK9oZJO+RJGC-7riO=Kz=UbRcAvQ-nDi=2GLyvEDpoc7g@mail.gmail.com>
 <CA+8MBbKA+P4vs3utSKQ-LPMW3ybrWOp=f3FH6ahv1YtwnMm5KA@mail.gmail.com>
 <5201A9BD.4090503@linux.vnet.ibm.com>
 <CA+8MBbJS0Dymn4OABi-rW9M5Bw-ZZ6DaEjQOW-oki+4ge4BDtg@mail.gmail.com>
 <5201D777.8060303@linux.vnet.ibm.com>
 <CA+8MBb+pkKpaEDs6J_XbzM3wzady2MjdU+jcDP+jH1f1VBxG5w@mail.gmail.com>
 <CA+8MBbJk63N3+YLUGDmGP5jrVc2mLa0Pn-QrqPk1xatknTVVEQ@mail.gmail.com>
 <520319B2.1080906@linux.vnet.ibm.com>
In-Reply-To: <520319B2.1080906@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "keescook@chromium.org" <keescook@chromium.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 08 August 2013 09:38 AM, Aruna Balakrishnaiah wrote:
> Hi Tony,
>
> On Thursday 08 August 2013 03:52 AM, Tony Luck wrote:
>> On Tue, Aug 6, 2013 at 10:35 PM, Tony Luck <tony.luck@gmail.com> wrote:
>>> ERST is at the whim of the BIOS writer (the ACPI standard doesn't provide any
>>> suggestions on record sizes).  My systems support ~6K record size.
>> Off by a little - 7896 bytes on my current machine.
>>
>>> efivars has, IIRC, a 1k limit coded in the Linux back end.
>> My memory was correct for this one.
>>
>> Adding a little tracing to pstore_getrecords() I see this:
>>
>> pstore: inflated 3880 bytes compressed to 17459 bytes
>> pstore: inflated 2567 bytes compressed to 17531 bytes
>> pstore: inflated 4018 bytes compressed to 17488 bytes
>>
>> Which isn't at all what I expected.  The ERST backend
>> advertised a bufsize of 7896, and I have the default
>> kmsg_bytes of 10240.  So on my forced panic the code
>> decided to create a three part pstore dump.  The sum of
>> the pieces is close to, but a little over the target of 10K.
>> But I don't understand why the compressed sizes are so
>> much smaller that the ERST backend block size.
>
> The sizes of compressed text depends on the nature of uncompressed
> data that is captured from kmsg_dump, considering the worst
> case of plain text based on experiments 45% was thecompression achieved.
> So we chose a buffer of size psinfo->bufsize * 100/45.
> If the uncompressed data captured was more of plain text nature then it
> would take up size close to ERST backend block size. Thats the reason
> you see compressed data of 2.5k to 4.0k. 2.5k would have more
> repeated occurrences than 4.0k.
>
> The sum of 3 pstore records should not have exceeded kmsg_bytes.
> Is it after adding total_len in the fix patch? Will take a look at it.

The sum of first two records is less than kmsg_bytes, so it captures the 3rd record.
Only after 3rd record is captured and written total is evaluated against kmsg_bytes
when itexceeds the limit it stops capturing the next one.

This shall happen even without compression right? If total is checked before
write this can be avoided.

- Aruna

>
>> The uncompressed sizes appear to be close to constant.
>> The compression ratios vary from 14% to 23%
>>
>> Why do we get three small parts instead of two bigger
>> ones close the the 7896 ERST bufsize?
>
> Same explanation as given above.
>
>>
>> -Tony
>>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
