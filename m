Return-Path: <pnasrat@redhat.com>
Subject: Re: [PATCH] yaboot: enable boot from iscsi target via ethernet
	devices on js20.
From: Paul Nasrat <pnasrat@redhat.com>
To: Doug Maxey <dwm@bebe.enoyolf.org>
In-Reply-To: <200604280605.k3S65tjv012348@bebe.enoyolf.org>
References: <200604280605.k3S65tjv012348@bebe.enoyolf.org>
Content-Type: text/plain
Date: Tue, 16 May 2006 16:20:47 -0400
Message-Id: <1147810848.4115.33.camel@enki.eridu>
Mime-Version: 1.0
Cc: yaboot-devel@ozlabs.org, Doug Maxey <dwm@enoyolf.org>,
	Linux PowerPC List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-04-28 at 01:05 -0500, Doug Maxey wrote:
> Certain levels of JS20 firmware will allow the system to boot from an
> iscsi target.  System OFW accomplishes this by setting up a virtual
> disk device with parameters.  These parameters, when passed back to
> OFW by yaboot, directs the FW to use virtual device over the ethernet
> port that will then access iscsi target as a block device.  This patch
> extracts those parameters from the property of the virtual device and
> passes them back to OFW to indicate the kernel is to be retrieved via
> the iscsi protocol.
> 
> Signed-off-by: Doug Maxey <dwm@austin.ibm.com>

Sorry for the delay in getting back to you - a few initial questions:

> diff --git a/second/file.c b/second/file.c

> @@ -185,16 +188,45 @@ parse_device_path(char *imagepath, char 
>  
>       if (!imagepath)
>  	  return 0;
> +
> +      /*
> +       * Do preliminary checking for an iscsi device; it may appear as
> +       * pure a network device (device_type == "network") if this is
> +       * ISWI.  This is the case on IBM systems doing an iscsi OFW
> +       * boot.
> +       */
> +     if (strstr(imagepath, ",iscsi"))

Is the , always guaranteed to be there - eg if I have boot
eth1:iscsi,ISCSIARGS  won't this check fail.

> diff --git a/second/prom.c b/second/prom.c
> index 5ec06b8..9bc5415 100644
> --- a/second/prom.c
> +++ b/second/prom.c
> @@ -174,6 +174,9 @@ prom_get_devtype (char *device)
>       int        result;
>       char       tmp[64];
>  
> +     if (strstr(device, ",iscsi"))
> +	  device = strcpy(tmp, "/vdevice/gscsi/disk");
> +

Ditto here.

Paul
