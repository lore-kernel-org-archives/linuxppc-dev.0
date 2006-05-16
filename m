Return-Path: <dwm@austin.ibm.com>
Message-Id: <200605162040.k4GKeUsY007712@falcon10.austin.ibm.com>
In-reply-to: <1147810848.4115.33.camel@enki.eridu> 
References: <200604280605.k3S65tjv012348@bebe.enoyolf.org> 
To: Paul Nasrat <pnasrat@redhat.com>
Subject: Re: [PATCH] yaboot: enable boot from iscsi target via ethernet
	devices on js20.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 May 2006 15:40:30 -0500
From: Doug Maxey <dwm@austin.ibm.com>
Cc: yaboot-devel@ozlabs.org, Linux PowerPC List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 16 May 2006 16:20:47 EDT, Paul Nasrat wrote:
>On Fri, 2006-04-28 at 01:05 -0500, Doug Maxey wrote:
>> Certain levels of JS20 firmware will allow the system to boot from an
>> iscsi target.  System OFW accomplishes this by setting up a virtual
>> disk device with parameters.  These parameters, when passed back to
>> OFW by yaboot, directs the FW to use virtual device over the ethernet
>> port that will then access iscsi target as a block device.  This patch
>> extracts those parameters from the property of the virtual device and
>> passes them back to OFW to indicate the kernel is to be retrieved via
>> the iscsi protocol.
>> 
>> Signed-off-by: Doug Maxey <dwm@austin.ibm.com>
>
>Sorry for the delay in getting back to you - a few initial questions:

np.  been on vacation the last 10 days.  Switzerland is nice, and Milan 
is cool. :)

>
>> diff --git a/second/file.c b/second/file.c
>
>> @@ -185,16 +188,45 @@ parse_device_path(char *imagepath, char 
>>  
>>       if (!imagepath)
>>  	  return 0;
>> +
>> +      /*
>> +       * Do preliminary checking for an iscsi device; it may appear as
>> +       * pure a network device (device_type == "network") if this is
>> +       * ISWI.  This is the case on IBM systems doing an iscsi OFW
>> +       * boot.
>> +       */
>> +     if (strstr(imagepath, ",iscsi"))
>
>Is the , always guaranteed to be there - eg if I have boot
>eth1:iscsi,ISCSIARGS  won't this check fail.

Yes, with the above command line this would fail. 

My point of reference are the bindings that we cannot yet talk about 
here, yet.  The device args would always be followed by a comma.  I suppose 
that we could just reference the string "iscsi", but then some wag 
would want to create some other property that included "iscsi" as a 
substring.  Maybe append a comma?


>
>> diff --git a/second/prom.c b/second/prom.c
>> index 5ec06b8..9bc5415 100644
>> --- a/second/prom.c
>> +++ b/second/prom.c
>> @@ -174,6 +174,9 @@ prom_get_devtype (char *device)
>>       int        result;
>>       char       tmp[64];
>>  
>> +     if (strstr(device, ",iscsi"))
>> +	  device = strcpy(tmp, "/vdevice/gscsi/disk");
>> +
>
>Ditto here.

likewise.  Maybe make it a #define so it would be common.

>
>Paul
>
