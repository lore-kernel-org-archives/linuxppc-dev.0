Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 396F31A0758
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 14:48:36 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B90731400B7
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 14:48:35 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Mon, 27 Apr 2015 14:48:34 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5DF6C2CE8050
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 14:48:31 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3R4mMAP41418928
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 14:48:31 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3R4lv0l005790
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 14:47:57 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/2] pci: Use Qemu created PCI device nodes
In-Reply-To: <20150424213058.2889af29@thh440s>
References: <1429700240-32373-2-git-send-email-nikunj@linux.vnet.ibm.com>
 <20150424213058.2889af29@thh440s>
Date: Mon, 27 Apr 2015 10:17:39 +0530
Message-ID: <87vbgiqis4.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: aik@ozlabs.ru, linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Thomas,


Thomas Huth <thuth@redhat.com> writes:
>  Hi Nikunj,
>
> On Wed, 22 Apr 2015 16:27:20 +0530
> Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:
>
>> PCI Enumeration has been part of SLOF. Now with hotplug code addition
>> in Qemu, it makes more sense to have this code a one place, i.e. Qemu.
>
> s/Qemu/QEMU/ and s/code a one place/code in one place/ ?

Sure

>
>> Adding routines to walk through the device nodes created by Qemu. SLOF
>> will configure the device/bridges and program the BARs for
>> communicating with the devices.
>
> I wonder whether it would make more sense to also set up the BARs etc.
> in QEMU instead of SLOF?
>
>> 
>> diff --git a/board-qemu/slof/pci-phb.fs b/board-qemu/slof/pci-phb.fs
>> index e307d95..30b7443 100644
>> --- a/board-qemu/slof/pci-phb.fs
>> +++ b/board-qemu/slof/pci-phb.fs
>> @@ -283,6 +283,41 @@ setup-puid
>>     THEN
>>  ;
>>  
>> +: phb-pci-walk-bridge ( -- )
>> +    phb-debug? IF ."   Calling pci-walk-bridge " pwd cr THEN
>> +
>> +    get-node child ?dup 0= IF EXIT THEN    \ get and check if we have children
>> +    BEGIN
>> +        dup                           \ Continue as long as there are children
>> +    WHILE
>
> Most Forth code uses the same indentation for the code between
> BEGIN...WHILE and WHILE...REPEAT ... so I think you could decrease the
> indentation of the following block by one level.

Sure, emacs is autoindenting this, so i ended up like this.

>
>> +            \ Set child node as current node:
>> +            dup set-node
>
> Below you are calling pci-device-setup which in turn might include some
> pci-class_*.fs or pci-device_*.fs files (or even run some FCODE?). At
> least pci-class_02.fs seems to use an INSTANCE VARIABLE, i.e. the
> instance template should get modified in that case ==> Please
> double-check whether you need to use extend-device here instead (I'm
> not 100% sure right now ... what happens
> for example when you run qemu with a network device that SLOF does not
> provide a pci-device_*.fs for? I guess it will try to include
> pci-class_02.fs and fail due to the INSTANCE VARIABLE ?)

I tried using rtl8139 device, SLOF does not provide driver for that. And
that did not create any problem.

Not sure about FCODE though, i will do more experiments with non
supported devices to check if things are fine. 

>
>> +            my-space pci-set-slot       \ set the slot bit
>
> pci-set-slot seems to rely on the pci-device-slots global variable.
> This is normally initialized by pci-probe-bus. Now that you provide
> your own implementation of that function below, I think it should
> likely also set up the pci-device-slots variable, shouldn't it?

Yes, I will need to initialize it for every bus probe to 0.

>
>> +            my-space pci-htype@         \ read HEADER-Type
>> +            7f and                      \ Mask bit 7 - multifunction device
>> +            CASE
>> +               0 OF my-space pci-device-setup ENDOF  \ | set up the device
>> +               1 OF my-space pci-bridge-setup ENDOF  \ | set up the bridge
>> +               dup OF my-space pci-htype@ pci-out ENDOF
>> +           ENDCASE
>> +           peer
>> +    REPEAT drop
>> +    get-parent set-node
>> +;
>
> The remaining part of the patch looks ok to me.

Regards,
Nikunj
