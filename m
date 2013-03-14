Return-Path: <paulus@ozlabs.org>
Date: Thu, 14 Mar 2013 19:51:55 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH2/11] Add PRRN Event Handler
Message-ID: <20130314085155.GB9841@iris.ozlabs.ibm.com>
References: <513AB2E3.6090209@linux.vnet.ibm.com>
 <513AB3C9.6010302@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <513AB3C9.6010302@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 08, 2013 at 10:00:09PM -0600, Nathan Fontenot wrote:
> From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
> 
> A PRRN event is signaled via the RTAS event-scan mechanism, which
> returns a Hot Plug Event message "fixed part" indicating "Platform
> Resource Reassignment". In response to the Hot Plug Event message,
> we must call ibm,update-nodes to determine which resources were
> reassigned and then ibm,update-properties to obtain the new affinity
> information about those resources.
> 
> The PRRN event-scan RTAS message contains only the "fixed part" with
> the "Type" field set to the value 160 and no Extended Event Log. The
> four-byte Extended Event Log Length field is repurposed (since no
> Extended Event Log message is included) to pass the "scope" parameter
> that causes the ibm,update-nodes to return the nodes affected by the
> specific resource reassignment.
> 
> This patch adds a handler in rtasd for PRRN RTAS events. The function
> pseries_devicetree_update() (from mobility.c) is used to make the
> ibm,update-nodes/ibm,update-properties RTAS calls. Updating the NUMA maps
> (handled by a subsequent patch) will require significant processing,
> so pseries_devicetree_update() is called from an asynchronous workqueue
> to allow rtasd to continue processing events.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

[snip]

> +static s32 update_scope;

Do we have a guarantee that there can only be one of these events
outstanding at a time?  If so it would be nice to document that in a
comment next to this declaration, so we know in future that this is
why this is safe.

Paul.
