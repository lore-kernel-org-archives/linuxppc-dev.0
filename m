Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRWkH1VsPzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 16:03:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powernv/opal: Handle OPAL_WRONG_STATE error from OPAL
 fails
In-Reply-To: <87efyz7y9j.fsf@linux.vnet.ibm.com>
References: <1482243419-23041-1-git-send-email-vipin@linux.vnet.ibm.com>
 <87sho58ifo.fsf@concordia.ellerman.id.au>
 <3539f32e-4caf-df07-7e8e-f1730da692dc@linux.vnet.ibm.com>
 <87a89qsyxd.fsf@concordia.ellerman.id.au>
 <47cb309b-f33a-9084-ad6c-f68f0e28a428@linux.vnet.ibm.com>
 <87efyz7y9j.fsf@linux.vnet.ibm.com>
Date: Mon, 20 Feb 2017 16:03:50 +1100
Message-ID: <87r32th2rt.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stewart Smith <stewart@linux.vnet.ibm.com> writes:

> Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:
>> On Monday 13 February 2017 06:13 AM, Michael Ellerman wrote:
>>> Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:
>>>
>>>> OPAL returns OPAL_WRONG_STATE for XSCOM operations
>>>>
>>>> done to read any core FIR which is sleeping, offline.
>>> OK.
>>>
>>> Do we know why Linux is causing that to happen?
>>
>> This issue is originally seen upon running STAF (Software Test
>> Automation Framework) stress tests and off-lining some cores
>> with stress tests running.
>>
>> It can also be re-created after off-lining few cores and following
>> one of below methods.
>> 1. Executing Linux "sensors" command
>> 2. Reading contents of file /sys/class/hwmon/hwmon0/tempX_input,
>>     where X is offline CPU.
>>
>> Its "opal_get_sensor_data" Linux API that that triggers
>> OPAL call "opal_sensor_read", performing XSCOM ops here.
>> If core is found sleeping/offline Linux throws up
>> "opal_error_code: Unexpected OPAL error" error onto console.
>>
>> Currently Linux isn't aware about OPAL_WRONG_STATE return code
>> from OPAL. Thus it prints "Unexpected OPAL error" message, same
>> as it would log for any unknown OPAL return codes.
>>
>> Seeing this error over console has been a concern for Test and
>> would puzzle real user as well. This patch makes Linux aware about
>> OPAL_WRONG_STATE return code from OPAL and stops printing
>> "Unexpected OPAL error" message onto console for OPAL fails
>> with OPAL_WRONG_STATE
>
> Ahh... so this is a DTS sensor, which indeed is just XSCOMs and we
> return the xscom_read return code in event of error.
>
> I would argue that converting to EIO in that instance is probably
> correct... or EAGAIN? EAGAIN may be more correct in the situation where
> the core is just sleeping.
>
> What kind of offlining are you doing?
>
> Arguably, the correct behaviour would be to remove said sensors when the
> core is offline.

Right, that would be ideal. There appear to be at least two other hwmon
drivers that are CPU hotplug aware (coretemp and via-cputemp).

But perhaps it's not possible to work out which sensors are attached to
which CPU etc., I haven't looked in detail.

In that case changing just opal_get_sensor_data() to handle
OPAL_WRONG_STATE would be OK, with a comment explaining that we might be
asked to read a sensor on an offline CPU and we aren't able to detect
that.

cheers
